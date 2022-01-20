//
//  AmAppDI.swift
//  Ammie
//
//  Created by JinYoung Jang on 20/1/22.
//

import Foundation

class AmAppDI {
    static let shared: AmAppDI = AmAppDI()
    
    private init() { }
    
    lazy var interactor: AmInteractor = AmInteractor(interface: AmRepo())
}
