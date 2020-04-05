//
//  UIView+Extension.swift
//  TestApp
//
//  Created by Nitin A on 05/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

extension UIView {
    
    // to set constraints for all the sides
    func makeConstraints(top: NSLayoutYAxisAnchor?,
                         left: NSLayoutXAxisAnchor?,
                         right: NSLayoutXAxisAnchor?,
                         bottom: NSLayoutYAxisAnchor?,
                         topMargin: CGFloat,
                         leftMargin: CGFloat,
                         rightMargin: CGFloat,
                         bottomMargin: CGFloat,
                         width: CGFloat,
                         height: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topMargin).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftMargin).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightMargin).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomMargin).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    // to set constraints for center axis
    func makeConstraints(centerX: NSLayoutXAxisAnchor, centerY: NSLayoutYAxisAnchor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        self.centerYAnchor.constraint(equalTo: centerY).isActive = true
    }
    
    // to add mutiple subviews in a single line
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
}
