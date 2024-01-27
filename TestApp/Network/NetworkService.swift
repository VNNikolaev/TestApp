//
//  NetworkService.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

import Combine
import Foundation

public protocol NetworkServicing {
    func request<T: Decodable>(request: URLRequest) -> AnyPublisher<T, NetworkError>
}

public final class NetworkService: NetworkServicing {
    public init() {}
    
    public func request<T: Decodable>(request: URLRequest) -> AnyPublisher<T, NetworkError> {
        URLSession.session.networkingPublisher(for: request)
            .mapError(handleError)
            .eraseToAnyPublisher()
    }
}

private extension NetworkService {
    func handleError(_ error: Error) -> NetworkError {
        switch error {
        case let error as DecodingError:
            return .decodingError(error)
        case let error as NSError:
            switch error.code {
            case NSURLErrorTimedOut, NSURLErrorNotConnectedToInternet:
                return .noInternetConnection
            default:
                return .unknownError
            }
        default:
            return .unknownError
        }
    }
}
