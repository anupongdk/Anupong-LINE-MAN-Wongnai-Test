//
//  AppInfo.swift
//  Anupong
//
//  Created by gone on 23/1/2567 BE.
//

import Foundation

struct AppInfoObject: Decodable {
    var appApi: String

    static let main = AppInfoObject()

    enum CodingKeys: String, CodingKey {
        case appApi = "baseURL"
    }

    init() {
        let decoder = PropertyListDecoder()
        let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist")
        let data = try? Data(contentsOf: infoPlistPath!)
        self = try! decoder.decode(AppInfoObject.self, from: data!)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        appApi = try container.decode(String.self, forKey: .appApi)
    }
}

struct AppInfo {
    static let main = AppInfo()
    private var info: AppInfoObject

    init() {
        do {
            let decoder = PropertyListDecoder()
            guard let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") else {
                fatalError("No plist found")
            }
            let data = try Data(contentsOf: infoPlistPath)
            info = try decoder.decode(AppInfoObject.self, from: data)
        } catch {
            fatalError("No appinfo.plist found")
        }
    }

    var appApi: String {
        info.appApi
    }
}
