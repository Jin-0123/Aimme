//
//  UIViewController+Rx.swift
//  Ammie
//
//  Created by JinYoung Jang on 20/1/22.
//

import Foundation
import UIKit
import RxSwift

extension UIViewController {
    
    static func push(on topVC: UIViewController) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: Self.id()) as? Self else { return }
        topVC.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showTextFieldAlert(title: String? = nil, message: String? = nil, confirmHandler: ((String?) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "완료", style: .default, handler: { action in
            confirmHandler?(alert.textFields?.first?.text)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showActionSheet(title: String, firstTitle: String, firstAction: ((UIAlertAction) -> Void)?, secondTitle: String, secondAction: ((UIAlertAction) -> Void)?, thirdTitle: String, thirdAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        let first = UIAlertAction(title: firstTitle, style: .default, handler: firstAction)
        let second = UIAlertAction(title: secondTitle, style: .default, handler: secondAction)
        let third = UIAlertAction(title: thirdTitle, style: .default, handler: thirdAction)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(first)
        alert.addAction(second)
        alert.addAction(third)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension Reactive where Base: UIViewController {
    
    func showTextFieldAlert(title: String? = nil, message: String? = nil) -> Observable<String?> {
        return Observable<String?>.create { [weak base] observer in
            base?.showTextFieldAlert(title: title, message: message, confirmHandler: {
                observer.onNext($0)
                observer.onCompleted()
            })
            return Disposables.create()
        }.observe(on: MainScheduler.instance)
    }
    
    func showActionSheet(title: String, firstTitle: String, secondTitle: String, thirdTitle: String) -> Observable<Int> {
        return Observable<Int>.create { [weak base] observer in
            base?.showActionSheet(title: title,
                                  firstTitle: firstTitle,
                                  firstAction: { _ in observer.onNext(0); observer.onCompleted() },
                                  secondTitle: secondTitle,
                                  secondAction: { _ in observer.onNext(1); observer.onCompleted() },
                                  thirdTitle: thirdTitle,
                                  thirdAction: { _ in observer.onNext(2); observer.onCompleted() })
            return Disposables.create()
        }.observe(on: MainScheduler.instance)
    }
}


// MARK: - String

extension String {

    var htmlToString: String? {
        guard let data = data(using: .utf8) else { return nil }
     
        return try? NSMutableAttributedString(data: data, options: [
            .documentType: NSMutableAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string
    }
    
    var prettyNames: String {
        if components(separatedBy: ["|"]).count > 2 {
            return String(replacingOccurrences(of: "|", with: " | ").dropLast().dropLast())
        } else {
            return replacingOccurrences(of: "|", with: "")
        }
    }
}
