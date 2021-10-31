//
//  Double+Extensions.swift
//  Weather
//
//  Created by Haykaz Melikyan on 31.10.21.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
