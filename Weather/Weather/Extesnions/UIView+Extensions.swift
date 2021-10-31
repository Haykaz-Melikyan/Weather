//
//  UIView+Extensions.swift
//  Weather
//
//  Created by Haykaz Melikyan on 29.10.21.
//

import UIKit
extension UIView {
    func addSubviewWithBoarder(view: UIView,
                               insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -insets.left).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: insets.right).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: -insets.top).isActive = true
    }
}



