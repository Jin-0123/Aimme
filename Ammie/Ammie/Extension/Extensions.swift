//
//  Extensions.swift
//  Ammie
//
//  Created by JinYoung Jang on 20/1/22.
//

import Foundation
import UIKit
import RxSwift

// MARK: - NSObject

extension NSObject {
    
    static func id() -> String {
        return String(describing: self)
    }
}


// MARK: - Date

extension Date {
    func toYYYYMMDD() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY. MM. dd"

        return dateFormatter.string(from: self)
    }
}
