//
//  URLSession+Extensions.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

import Combine
import Foundation

extension URLSession {
    static var session: URLSession {
        let discCapasity = 200 * 1024 * 1024
        let session = URLSession(configuration: .default)
        session.configuration.urlCache = .init(memoryCapacity: .zero, diskCapacity: discCapasity)
        return session
    }
    
    func networkingPublisher<T: Decodable>(
        for request: URLRequest,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
