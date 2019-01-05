//
//  Extensions.swift
//  List
//
//  Created by Emmanuel Ortiguela on 1/1/19.
//  Copyright © 2019 Emmanuel Ortiguela. All rights reserved.
//

import RxCocoa
import RxSwift

extension ObservableType {
    func toDriver() -> Driver<E> {
        return self
            .asDriver { _ in
                return Driver<E>.empty()
        }
    }
}

extension Observable where Element == (HTTPURLResponse, Data)  {
    func decode<T : Decodable>() -> Observable<T> {
        return self.map {
            guard let t = try? JSONDecoder().decode(T.self, from: $0.1) else {
                return NSObject() as! T
            }
            return t
        }
    }
}
