//
//  RoundLabel.swift
//  iOSExtension
//
//  Created by HungNV on 3/27/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

class RoundLabel: UILabel {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
