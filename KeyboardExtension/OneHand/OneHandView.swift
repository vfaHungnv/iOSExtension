//
//  OneHandView.swift
//  iOSExtension
//
//  Created by HungNV on 3/28/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

protocol OneHandViewDelegate: class {
    func didTapKeyLeft()
    func didTapKeyRight()
    func didTapKeyBasic()
    func didTapKeyLanguage()
    func didTapKeyEnter()
}

class OneHandView: UIView {
    
    weak var delegate: OneHandViewDelegate?
    var textProxy:UITextDocumentProxy?
    
    @IBAction func didTapKeyboard(_ sender: Any) {
        if let op = (sender as AnyObject).titleLabel??.text {
            switch op {
            case "kb_left":
                self.delegate?.didTapKeyLeft()
                break
            case "kb_right":
                self.delegate?.didTapKeyRight()
                break
            case "kb_basic":
                self.delegate?.didTapKeyBasic()
                break
            case "delete":
                if self.textProxy != nil {
                    self.textProxy?.deleteBackward()
                }
                break
            case "language":
                self.delegate?.didTapKeyLanguage()
                break
            case "enter":
                self.delegate?.didTapKeyEnter()
                break
            default:
                if self.textProxy != nil {
                    self.textProxy?.insertText(op)
                }
                break
            }
        }
    }
}
