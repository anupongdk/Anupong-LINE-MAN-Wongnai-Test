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

protocol EndpointProtocol: TargetType {
    associatedtype R
    var key: R { get }
    var method: Moya.Method { get }
}

protocol AppEndpoints: EndpointProtocol {}

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
