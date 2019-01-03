//
//  PlainTableViewCell.swift
//  List
//
//  Created by Emmanuel Ortiguela on 1/1/19.
//  Copyright © 2019 Emmanuel Ortiguela. All rights reserved.
//

import UIKit

class PlainTableViewCell: UITableViewCell {

    func bind(comic: ComicModel) {
        self.textLabel?.text = comic.title
        self.load(url: comic.imageURL)
    }
    
    private func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView!.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
        }
    }

}
