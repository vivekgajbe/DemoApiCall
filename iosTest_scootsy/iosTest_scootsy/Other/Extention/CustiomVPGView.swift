//
//  CustiomVPGView.swift
//  iosTest_scootsy
//
//  Created by vivek G on 15/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import UIKit

@IBDesignable
class CustiomVPGView: UIView {

    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return UIColor.lightGray
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }

}
