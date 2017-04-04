//
//  TextView.swift
//  iOSExtension
//
//  Created by HungNV on 3/28/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

protocol TextViewDelegate: class {
    func didTapKeyLanguageInTextView()
    func didTapNextKeyboardInTextView()
}

class TextView: UIView {
    
    weak var delegate: TextViewDelegate?
    var textProxy:UITextDocumentProxy?

    @IBAction func didTapLanguage(_ sender: Any) {
        self.delegate?.didTapKeyLanguageInTextView()
    }
    
    @IBAction func didTapNextKeyboard(_ sender: Any) {
        self.delegate?.didTapNextKeyboardInTextView()
    }
    
    @IBAction func didTapKeyboard(_ sender: Any) {
        if let op = (sender as AnyObject).titleLabel??.text {
            if self.textProxy != nil {
                self.textProxy?.insertText(op)
            }
        }
    }
}
