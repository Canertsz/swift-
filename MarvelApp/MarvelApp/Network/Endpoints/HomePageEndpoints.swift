//
//  HomePageEndpoints.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 5.12.2024.
//

import Foundation

enum HomePageEndpoints: EndpointProtocol {
    case getCharacters(limit: Int)

    var url: String {
        switch self {
        case .getCharacters:
            return "https://gateway.marvel.com:443/v1/public/characters"
        }
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
            return ["Content-Type": "application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getCharacters(let limit):
            return [URLQueryItem(name: "limit", value: "\(limit)")]
        }
    }
}
