//
//  ComicService.swift
//  List
//
//  Created by Emmanuel Ortiguela on 12/28/18.
//  Copyright © 2018 Emmanuel Ortiguela. All rights reserved.
//

import Foundation
import RxSwift

class ComicService {
    private let comicsSubject: BehaviorSubject<Array<Comic>> = BehaviorSubject.init(value: [])
    
    func getComics() -> Observable<Array<Comic>> {
    
        return Observable.deferred({ () -> Observable<Array<Comic>> in
            var urlComponents = URLComponents()
            let dateDescriptor = URLQueryItem(name: "dateDescriptor", value: "thisMonth")
            let limit = URLQueryItem(name: "limit", value: "20")
            let timeStamp = URLQueryItem(name: "ts", value: "1")
            let apiKey = URLQueryItem(name: "apikey", value: "9d40db1630da003c1fb826d96bef65eb")
            let hash = URLQueryItem(name: "hash", value: "b167f09767dfce350bc36a144429c1b5")
            urlComponents.queryItems = [dateDescriptor, limit, apiKey, hash, timeStamp]
            urlComponents.port = 443
            urlComponents.scheme = "https"
            urlComponents.host = "gateway.marvel.com"
            urlComponents.path = "/v1/public/comics"
            
            let urlRequest = URLRequest(url: urlComponents.url!)
            let urlSession = URLSession(configuration: URLSessionConfiguration.default)
            let task = urlSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                do {
                    let marvelResponse = try JSONDecoder().decode(MarvelResponse.self, from: data!)
                    self.comicsSubject.onNext(marvelResponse.data.results)
                } catch  {}
            })
            task.resume()
            return self.comicsSubject
        }).subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }
}
