//
//  CoinListEntity.swift
//  Anupong
//
//  Created by gone on 24/1/2567 BE.
//

import Foundation
import OptionallyDecodable

// MARK: - CoinRanking
struct CoinListResponse: Codable {
    let status: String
    let data: CoinListResponseData
}

struct CoinListSearchRequest: Encodable {
    var search: String

    enum CodingKeys: String, CodingKey {
        case search
        case size

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(search, forKey: .search)
    }
}

// MARK: - DataClass
struct CoinListResponseData: Codable {
    let stats: CoinStats
    let coins: [Coin]
}

// MARK: - Coin
struct Coin: Codable {
    let uuid, symbol, name, color: String
    let iconURL: String
    let marketCap, price: String
    let listedAt, tier: Int
    let change: String
    let rank: Int
    let sparkline: [String?]
    let lowVolume: Bool
    let coinrankingURL: String
    let the24HVolume, btcPrice: String

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconURL = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinrankingURL = "coinrankingUrl"
        case the24HVolume = "24hVolume"
        case btcPrice
    }
}

// MARK: - Stats
struct CoinStats: Codable {
    let total, totalCoins, totalMarkets, totalExchanges: Int
    let totalMarketCap, total24HVolume: String

    enum CodingKeys: String, CodingKey {
        case total, totalCoins, totalMarkets, totalExchanges, totalMarketCap
        case total24HVolume = "total24hVolume"
    }
}
