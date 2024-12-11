//
//  NetworkManager.swift
//  MarvelApp
//
//  Created by Caner Tüysüz on 5.12.2024.
//


import Foundation
import CryptoKit

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

protocol EndpointProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(String)
    
    var title: String {
        return "Error (\(errorCode))"
    }
    
    var description: String {
        switch self {
        case .invalidURL, .decodingError:
            return "An error occured.."
        case .serverError:
            return "There is a server problem"
        }
    }
    
    var errorCode: Int {
        switch self {
        case .invalidURL:
            return 1
        case .decodingError:
            return 2
        case .serverError:
            return 3
        }
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func makeRequest<T: Decodable>(endpoint: EndpointProtocol, responseType: T.Type, completion: ( @escaping (Swift.Result<T, NetworkError>) -> Void)) {
        
        guard var components = URLComponents(string: endpoint.url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        components.queryItems = endpoint.queryItems
        
        for queryParam in NetworkManagerHelpers.generateQueryParams() {
            components.queryItems?.append(queryParam)
        }
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.serverError("server error")))
                return
            }
            
            do {
                guard let data = data else { return }
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print(String(describing: error))
                completion(.failure(.decodingError))
            }

        }.resume()
    }
  
}

class NetworkManagerHelpers {
    static func generateQueryParams() -> [URLQueryItem] {
        guard
            let publicKey = ProcessInfo.processInfo.environment["PUBLIC_KEY"],
            let privateKey = ProcessInfo.processInfo.environment["PRIVATE_KEY"]
        else {
            fatalError("Environment variables PUBLIC_KEY and PRIVATE_KEY are required.")
        }
        
        let ts = "\(Date().timeIntervalSince1970)"
        let hashInput = "\(ts)\(privateKey)\(publicKey)"
        
        let hash = Insecure.MD5.hash(data: hashInput.data(using: .utf8)!)
        let hashString = hash.map { String(format: "%02hhx", $0) }.joined()
        
        return [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hashString)
        ]
    }
}
