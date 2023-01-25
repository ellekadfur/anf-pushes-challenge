//
//  Observable.swift
//  ANF Code Test
//
//  Created by Elle Kadfur on 1/18/23.
//

import Foundation

class Observable<T> {
    
    typealias Listener = (T) -> Void
    var listener:Listener?
    var value: T{
        didSet{
            listener?(value)
        }
    }
    
    init(_ value:T){
        self.value = value
    }
    
    func observe( listener:@escaping Listener) {
        self.listener = listener
    }
    
}
