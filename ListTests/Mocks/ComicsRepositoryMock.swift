//
//  ComicsRepositoryMock.swift
//  ListTests
//
//  Created by Emmanuel Ortiguela on 1/2/19.
//  Copyright © 2019 Emmanuel Ortiguela. All rights reserved.
//

import RxSwift
@testable import List

class ComicsRepositoryMock : ComicsRepositoryProtocol {
    private let data: ReplaySubject<Array<ComicModel>>
    
    init(data: ReplaySubject<Array<ComicModel>>) {
        self.data = data
    }
    func getComics() -> Observable<Array<ComicModel>> {
        return data
    }
}
