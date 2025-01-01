//
//  HashHelper.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 1.01.2025.
//

import CryptoKit

final class HashHelper {
    static func generateHash(ts: String, publicKey: String, privateKey: String) -> String? {
        let ts = NetworkManagerHelpers.generateTS()

        guard let publicKey = NetworkManagerHelpers.generatePublicKey() else {
            print("Public key is missing")
            return nil
        }

        guard let privateKey = NetworkManagerHelpers.generatePrivateKey() else {
            print("Private key is missing")
            return nil
        }

        let hashInput = "\(ts)\(privateKey)\(publicKey)"

        guard let data = hashInput.data(using: .utf8) else {
            print("Failed to encode hash input as UTF-8")
            return nil
        }

        let hash = Insecure.MD5.hash(data: data)
        let hashString = hash.map { String(format: "%02hhx", $0) }.joined()

        return hashString

    }
}
