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
    
        return comicsSubject
    }
}

struct MarvelResponse : Codable {
    var data: MarvelData
}

struct MarvelData : Codable {
    var results: [Comic]
}

struct Comic : Codable {
    var title: String
    var thumbnail: Image
}

struct Image : Codable {
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    let url: URL
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        
         let url = URL(string: "\(path).\(fileExtension)")
        
        self.url = url!
    }
}

