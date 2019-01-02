//
//  ComicsViewModel.swift
//  List
//
//  Created by Emmanuel Ortiguela on 1/1/19.
//  Copyright © 2019 Emmanuel Ortiguela. All rights reserved.
//

import RxSwift
class ComicsViewModel {
    
    private let comicsRepository: ComicsRepository
    
    init(comicsRepository: ComicsRepository) {
        self.comicsRepository = comicsRepository
    }
    
    func getComics() -> Observable<Array<Comic>> {
        return comicsRepository.getComics()
    }
}
