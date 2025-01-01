//
//  HomePageEndpoints.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 5.12.2024.
//

import Foundation

enum HomepageEndpoints: BaseEndpoint {
    case getCharacters
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/v1/public/characters"
        }
    }
    
    var url: String {
        return baseURL + path
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCharacters:
            return nil
        }
    }
    
    var limit: Int {
        switch self {
        case .getCharacters:
            return 20
        }
    }
    
    var queryItems: [String: String?]? {
        switch self {
        case .getCharacters:
            return [
                "limit": "\(self.limit)",
                "ts": NetworkManagerHelpers.generateTS(),
                "apikey": NetworkManagerHelpers.generatePublicKey(),
                "hash": NetworkManagerHelpers.generateHash()
            ]
        }
    }
}
