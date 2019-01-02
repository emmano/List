//
//  Models.swift
//  List
//
//  Created by Emmanuel Ortiguela on 1/1/19.
//  Copyright © 2019 Emmanuel Ortiguela. All rights reserved.
//

import Foundation
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
