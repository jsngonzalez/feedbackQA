//
//  UIButton.swift
//  FeedBackQA
//
//  Created by User on 3/27/20.
//

import Foundation
import UIKit

@IBDesignable
open class FBQAButton: UIButton {
    
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable open var borderColor: UIColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0){
        didSet{
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
}
