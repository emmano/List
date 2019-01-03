//
//  ComicsRepository.swift
//  List
//
//  Created by Emmanuel Ortiguela on 1/1/19.
//  Copyright © 2019 Emmanuel Ortiguela. All rights reserved.
//

import RxSwift
class ComicsRepository : ComicsRepositoryProtocol {
    
    private let comicService: ComicService
    init(comicsService: ComicService) {
        self.comicService = comicsService
    }
    
    func getComics() -> Observable<Array<ComicModel>> {
        return comicService.getComics().map({ comics in
            return comics.map({ (comic: Comic) -> ComicModel in
                return ComicModel(title: comic.title, imageURL: comic.thumbnail.url)
            })
        })
    }
}

protocol ComicsRepositoryProtocol {
    func getComics() -> Observable<Array<ComicModel>>
}
