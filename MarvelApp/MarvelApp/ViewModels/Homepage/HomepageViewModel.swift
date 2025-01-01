//
//  HomepageViewModel.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 4.12.2024.
//

import Foundation

protocol HomepageViewModelProtocol {
    func viewDidLoad()
}

final class HomepageViewModel: HomepageViewModelProtocol {
    
    private let repository: HomepageRepositoryProtocol
    
    init(repository: HomepageRepositoryProtocol) {
        self.repository = repository
    }
    
    func viewDidLoad() {
        fetchCharacters()
    }
}

private extension HomepageViewModel {
    func fetchCharacters() {
        repository.fetchCharacters { [weak self] result in
            switch result {
            case .success(let character):
                print("Fetched characters: \(character)")
            case .failure(let error):
                print("Error fetching characters: \(error)")
            }
        }
    }
}
