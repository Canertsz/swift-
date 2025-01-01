//
//  EnvironmentKeys.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 1.01.2025.
//

import Foundation

struct EnvironmentKeys {
    static let publicKey: String = {
        guard let key = ProcessInfo.processInfo.environment["PUBLIC_KEY"] else {
            fatalError("PUBLIC_KEY is not set in the environment variables")
        }
        return key
    }()
    
    static let privateKey: String = {
        guard let key = ProcessInfo.processInfo.environment["PRIVATE_KEY"] else {
            fatalError("PRIVATE_KEY is not set in the environment variables")
        }
        return key
    }()
}
