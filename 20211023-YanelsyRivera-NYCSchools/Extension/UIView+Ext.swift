//
//  UIView+Ext.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/25/21.
//

import UIKit

extension UIView {
    
    func rounded() {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 4
    }
}
