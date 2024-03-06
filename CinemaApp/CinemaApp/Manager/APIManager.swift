//
//  APIManager.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/4.
//

import Foundation
import Combine
import UIKit

protocol APIManagerProtocol {
    func request<T: Codable>(modelType: T.Type, endPointType: EndPointType) -> AnyPublisher<T, APIError>
}

final class APIManager {
    static let shared = APIManager()
    
    func request<T: Codable>(modelType: T.Type, endPointType: EndPointType) -> AnyPublisher<T, APIError> {
        return fetch(endPointType: endPointType)
            .decode(type: modelType.self, decoder: JSONDecoder())
            .mapError { error in
                return error as? APIError ?? .unknownError
            }.eraseToAnyPublisher()
    }
    
    private func fetch(endPointType: EndPointType) -> AnyPublisher<Data, APIError> {
        guard let url = endPointType.url else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPointType.method.rawValue
        request.allHTTPHeaderFields = endPointType.headers
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse(httpStatusCode: 0)
                }
                
                guard (200..<299).contains(httpResponse.statusCode) else {
                    throw APIError.errorType(type: httpResponse.statusCode)
                }
                
                return data
            }.mapError { error in
                return error as? APIError ?? .unknownError
            }.eraseToAnyPublisher()
    }
    
    func download(endPointType: EndPointType) -> AnyPublisher<UIImage?, APIError> {
        return fetch(endPointType: endPointType)
            .map { UIImage(data: $0) }
            .eraseToAnyPublisher()
    }
}

final class MockAPIManager: APIManagerProtocol {
    static let shared = MockAPIManager()
    
    func request<T: Codable>(modelType: T.Type, endPointType: EndPointType) -> AnyPublisher<T, APIError> {
        return fetch(endPointType: endPointType)
            .decode(type: modelType.self, decoder: JSONDecoder())
            .mapError { error in
                return error as? APIError ?? .unknownError
            }.eraseToAnyPublisher()
    }
    
    private func fetch(endPointType: EndPointType) -> AnyPublisher<Data, APIError> {
        return Future<Data, APIError> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let url = Bundle.main.url(forResource: endPointType.localName, withExtension: "json")!
                do {
                    let data = try Data(contentsOf: url)
                    promise(.success(data))
                }catch {
                    promise(.failure(APIError.decodingError(error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
