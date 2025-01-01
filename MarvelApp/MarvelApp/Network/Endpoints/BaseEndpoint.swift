//
//  BaseEndpoint.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 1.01.2025.
//

protocol BaseEndpoint: EndpointProtocol {
    var baseURL: String { get }
}

extension BaseEndpoint {
    var baseURL: String {
        "https://gateway.marvel.com/v1/public"
    }
}
