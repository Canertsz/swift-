//
//  HomepageViewModel.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 4.12.2024.
//

import Foundation

protocol HomepageViewModelProtocol {
    func fetchCharacters()
}

class HomepageViewModel: HomepageViewModelProtocol {
        
    func fetchCharacters() {
        NetworkManager.shared.makeRequest(endpoint: HomePageEndpoints.getCharacters(limit: 20), responseType: CharacterDataWrapper.self) { response in
            switch response {
            case .success(let characters):
                print("Fetched Characters: \(characters)")
            case .failure(let error):
                print("Failed to fetch Characters: \(error)")
            }
        }
    }
}