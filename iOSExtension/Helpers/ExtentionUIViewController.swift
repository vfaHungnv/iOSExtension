//
//  ExtentionUIViewController.swift
//  iOSExtension
//
//  Created by HungNV on 3/26/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK:- Set border
    func setBorderButton(btn: UIButton, isCircle: Bool) {
        let corner = isCircle ? btn.frame.size.width/2 : btn.frame.size.height/2
        btn.layer.cornerRadius = corner
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.brown.cgColor
        btn.clipsToBounds = true
    }
}
