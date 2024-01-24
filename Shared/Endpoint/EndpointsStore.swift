//
//  EndpointsStore.swift
//  Anupong
//
//  Created by gone on 23/1/2567 BE.
//

import Foundation
import Alamofire
import Moya

struct EndpointStore: Codable {
    var name: String
    var path: String
}

protocol EndpointProtocol: TargetType {
    associatedtype R
    var key: R { get }
    var method: Moya.Method { get }
}

protocol AppEndpoints: EndpointProtocol {}

struct ApiEndPointStore {
    private var _allEndpoints: [EndpointStore]?

    static let shared = ApiEndPointStore()

    init() {
        let decoder = PropertyListDecoder()
        guard let plistUrl = R.file.endpointsStorePlist() else {
            return
        }
        let data = try? Data(contentsOf: plistUrl)
        _allEndpoints = try? decoder.decode([EndpointStore].self, from: data!)
    }

    func find(endpoint: some EndpointProtocol) -> String {
        _allEndpoints?.filter { $0.name == endpoint.key as! String }.first?.path ?? ""
    }
}

extension AppEndpoints {
    var key: String {
        ""
    }
    var method: Moya.Method {
        .get
    }

    var baseURL: URL {
        try! AppInfo.main.appApi.asURL()
    }

    var path: String {
        ApiEndPointStore.shared.find(endpoint: self)
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String: String]? {
        ["content-type": "application/json"]
    }
}


enum Endpoints {
    
    enum coin: AppEndpoints {
        typealias R = String
        case coin
        case search([String: Any])
        case coinDetail(String)

        var path: String {
            let path = ApiEndPointStore.shared.find(endpoint: self)
            switch self {
            case .coinDetail(let uuid):
                return String(format: path, "\(uuid)")
            default:
                return path
            }
        }

        var key: String {
            switch self {
            case .coin: return "coin"
            case .search: return "search"
            case .coinDetail: return "coin-detail"
            }
        }

        var method: Moya.Method {
            .get
        }

        var task: Task {
            switch self {
            case .search(let req):
                return .requestParameters(parameters: req, encoding: URLEncoding.queryString)
            default:
                return .requestPlain
            }
        }
    }
}
