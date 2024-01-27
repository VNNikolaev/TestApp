//
//  MainViewModel.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 27.01.2024.
//

//import Combine
import Foundation

class MainViewModel {
    
    private let networkFacade: NetworkFacade
//    private var cancellable: Set<AnyCancellable> = []
    
    @Published var characters: [Character] = []
    
    init(networkFacade: NetworkFacade) {
        self.networkFacade = networkFacade
    }
    
    func fetchCharacters() {
        networkFacade.requestCharacters()
            .assign(to: &$characters)
    }
    
    func namberOfRowsInSection(_ section: Int) -> Int {
        return characters.count
    }
    
}
