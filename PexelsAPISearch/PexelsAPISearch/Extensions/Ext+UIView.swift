//
//  Ext+UIView.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/13/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit

extension UIView {
    
    func curve() {
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
    }
    
    func xtreamCurve() {
        self.layer.cornerRadius = 40
    }
    
    // This was to help with constrants (I followed a tutorial)
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
