//
//  BindingEventCell.swift
//  Ammie
//
//  Created by JinYoung Jang on 20/1/22.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class BindingEventCell<T: CaseIterable>: UITableViewCell {
    
    private var disposeBag: DisposeBag?

    func getEvent(event: T) -> Observable<T>? { nil }

    func bind(to consumer: OneConsumer<T>) {
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag

        for event in T.allCases {
            if let eventObservable = getEvent(event: event) {
                eventObservable.subscribe({ event in
                    guard case .next(let item) = event else { return }
                    consumer.accept(item: item)
                }).disposed(by: disposeBag)
            }
        }
    }
    
    func bind(to relay: PublishRelay<T>) {
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag

        for event in T.allCases {
            if let eventObservable = getEvent(event: event) {
                eventObservable
                    .bind(to: relay)
                    .disposed(by: disposeBag)
            }
        }
    }
}
