//
//  RoundButton.swift
//  iOSExtension
//
//  Created by HungNV on 3/27/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
