//
//  CustomUI.swift
//  BarkDevApp
//
//  Created by Richie Sun on 2/4/23.
//

import Foundation
import UIKit

class CTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


