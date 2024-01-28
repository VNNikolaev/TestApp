//
//  MainViewModel.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

import Foundation

class MainViewModel {
    
    private let networkFacade: NetworkFacade
    
    @Published private(set) var characters: [Character] = []
    @Published private(set) var cellDataSource: [MainCellViewModel] = []
    
    init(networkFacade: NetworkFacade) {
        self.networkFacade = networkFacade
        setupBindings()
    }
    
    func fetchCharacters() {
        networkFacade.requestCharacters()
            .assign(to: &$characters)
    }
    
    func namberOfRowsInSection(_ section: Int) -> Int {
        return characters.count
    }
}

extension MainViewModel {
    private func setupBindings() {
        $characters
            .map { $0.map { MainCellViewModel($0) } }
            .assign(to: &$cellDataSource)
    }
}
