//
//  View Attributes.swift
//  Login Screen
//
//  Created by Warren Hansen on 8/15/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UITextField {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
