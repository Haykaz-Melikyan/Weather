//
//  NSObject+Extensions.swift
//  Weather
//
//  Created by Haykaz Melikyan on 30.10.21.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self.self)
    }
}
