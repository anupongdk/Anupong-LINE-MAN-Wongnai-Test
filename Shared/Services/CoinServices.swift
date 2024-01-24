//
//  CoinServices.swift
//  Anupong
//
//  Created by gone on 24/1/2567 BE.
//

import Foundation
import Moya

class CoinListServices {
    typealias CoinListCallback = (Result<CoinListResponse, Error>) -> Void
    
    static var provider: MoyaProvider<Endpoints.coin> {
        MoyaProvider<Endpoints.coin>()
    }
    
    
    func getCoinList(onComplete: @escaping CoinListCallback) {
        CoinListServices.provider.request(.coin, completion: { result in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(CoinListResponse.self, from: response.data)
                    switch result.status {
                    case "success":
                        onComplete(.success(result))
                    case "fail":
                        onComplete(.failure(CoinError.unknown))
                        break
                        
                    default:
                       break
                    }
                } catch {
                    onComplete(.failure(error))
                }
            case let .failure(error):
                onComplete(.failure(error))
            }
        })
    }
    
    
}

enum CoinError: ServiceError {
    case coinNotFound
    case validationError
    case unknown
    
    init(with error: MoyaError) {
        let code = error.errorCode
        switch code {
        case 404: self = .coinNotFound
        case 422: self = .validationError
        default: self = .unknown
        }
    }

    var description: String {
        return ""
    }

    var field: ServiceErrorField {
        .unknow
    }
}


protocol ServiceError: Error {
    var description: String { get }
    var field: ServiceErrorField { get }
}
indirect enum ServiceErrorField: Hashable {
    case unknow
}
