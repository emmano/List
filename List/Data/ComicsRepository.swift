//
//  ComicsRepository.swift
//  List
//
//  Created by Emmanuel Ortiguela on 1/1/19.
//  Copyright © 2019 Emmanuel Ortiguela. All rights reserved.
//

import RxSwift
class ComicsRepository {
    
    private let comicService: ComicService
    init(comicsService: ComicService) {
        self.comicService = comicsService
    }
    
    func getComics() -> Observable<Array<Comic>> {
        return comicService.getComics()
    }
}
