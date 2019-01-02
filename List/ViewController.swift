//
//  ViewController.swift
//  List
//
//  Created by Emmanuel Ortiguela on 12/27/18.
//  Copyright © 2018 Emmanuel Ortiguela. All rights reserved.
//

import RxSwift
import RxCocoa
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let bag = DisposeBag()
    private let comicViewModel = ComicsViewModel.init(comicsRepository:ComicsRepository.init(comicsService:ComicService()))
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        comicViewModel
            .getComics()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .toDriver()
            .drive(tableView.rx.items(cellIdentifier: "PlainCell", cellType: PlainTableViewCell.self)){ (index, comic, cell) in
            cell.bind(comic: comic)
        }.disposed(by: bag)
    
    }
}
