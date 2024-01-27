//
//  NetworkFacade.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

import Combine
import Foundation

public final class NetworkFacade {
    private let networkService: NetworkServicing
    private let base = URL(string: "https://rickandmortyapi.com/api/")!
    
    public init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    func requestCharacters() -> AnyPublisher<[Character], Never> {
        let request = URLRequest(url: base.appendingPathComponent("character"))
        return networkService.request(request: request)
            .map { $0 as CharactersModel }
            .catch { [weak self] networkError -> Empty in
                self?.handleError(networkError)
                return Empty()
            }
            .map(\.results)
            .eraseToAnyPublisher()
    }
}

extension NetworkFacade {
    private func handleError(_ error: NetworkError) {}
}
