//
//  File.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 23.12.2024.
//

import Foundation

protocol HomepageRepositoryProtocol {
    func fetchCharacters(completion: @escaping (NetworkResult<CharacterDataWrapper>) -> Void)
}

final class HomepageRepository: HomepageRepositoryProtocol {
    
    func fetchCharacters(completion: @escaping (NetworkResult<CharacterDataWrapper>) -> Void) {
        NetworkManager.shared.makeRequest(
            endpoint: HomepageEndpoints.getCharacters,
            responseType: CharacterDataWrapper.self,
            completion: completion
        )
    }
    
}
