//
//  ComicsViewModelTest.swift
//  ListTests
//
//  Created by Emmanuel Ortiguela on 1/2/19.
//  Copyright © 2019 Emmanuel Ortiguela. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

class ComicsViewModelTest: XCTestCase {
    
    var testObject: ComicsViewModel!
    let data: ReplaySubject<Array<ComicModel>> = ReplaySubject<Array<ComicModel>>.create(bufferSize: 1)
    let testScheduler: TestScheduler = TestScheduler.init(initialClock: 0)
    let bag: DisposeBag = DisposeBag()

    override func setUp() {
        testObject = ComicsViewModel.init(comicsRepository: ComicsRepositoryMock.init(data: data))
    }

    override func tearDown() {
        testObject = nil
    }

    func testExample() {
        let testObserver: TestableObserver<Array<ComicModel>> = testScheduler.createObserver([ComicModel].self)
        testObject.getComics().toDriver().drive(testObserver).disposed(by: bag)
        
        let comicModel: ComicModel = ComicModel(title: "title", imageURL: URL(string: "http://example.com")!)
        let comicsList: [ComicModel] = [comicModel]
        
        testScheduler.createColdObservable([.next(10, comicsList)]).bind(to: data).disposed(by: bag)
        
        testScheduler.start()
    
        XCTAssertEqual(testObserver.events, [
           Recorded.next(10, comicsList)
        ])
    }


}
