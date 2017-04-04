//
//  KeyboardViewController.swift
//  KeyboardExtension
//
//  Created by HungNV on 3/20/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

enum TypeKeyboard {
    case Text
    case Calculator
    case Basic
    case OneHandLeft
    case OneHandRight
}

class KeyboardViewController: UIInputViewController {
    
    var textView: TextView!
    var calculatorView: CalculatorView!
    var oneHandView: OneHandView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface(type: .Text)
    }
    
    func loadInterface(type: TypeKeyboard) {
        switch type {
        case .Text:
            self.textView = Bundle.main.loadNibNamed("TextView", owner: self, options: nil)?[0] as! TextView!
            self.textView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(textView)
            self.view.backgroundColor = textView.backgroundColor
            self.textView.delegate = self
            self.textView.textProxy = self.textDocumentProxy
            break
            
        case .Calculator:
            self.calculatorView = Bundle.main.loadNibNamed("CalculatorView", owner: self, options: nil)?[0] as! CalculatorView!
            self.calculatorView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(calculatorView)
            self.view.backgroundColor = calculatorView.backgroundColor
            self.calculatorView.delegate = self
            break
            
        case .Basic:
            self.oneHandView = Bundle.main.loadNibNamed("BasicView", owner: self, options: nil)?[0] as? UIView as! OneHandView!
            self.oneHandView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(oneHandView)
            self.view.backgroundColor = oneHandView.backgroundColor
            self.oneHandView.delegate = self
            self.oneHandView.textProxy = self.textDocumentProxy
            break
            
        case .OneHandLeft:
            self.oneHandView = Bundle.main.loadNibNamed("OneHandLeftView", owner: self, options: nil)?[0] as? UIView as! OneHandView!
            self.oneHandView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(oneHandView)
            self.view.backgroundColor = oneHandView.backgroundColor
            self.oneHandView.delegate = self
            self.oneHandView.textProxy = self.textDocumentProxy
            break
            
        case .OneHandRight:
            self.oneHandView = Bundle.main.loadNibNamed("OneHandRightView", owner: self, options: nil)?[0] as? UIView as! OneHandView!
            self.oneHandView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.addSubview(oneHandView)
            self.view.backgroundColor = oneHandView.backgroundColor
            self.oneHandView.delegate = self
            self.oneHandView.textProxy = self.textDocumentProxy
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
}

extension KeyboardViewController: TextViewDelegate {
    func didTapKeyLanguageInTextView() {
        self.advanceToNextInputMode()
    }
    
    func didTapNextKeyboardInTextView() {
        self.textView.removeFromSuperview()
        loadInterface(type: .Calculator)
    }
}

extension KeyboardViewController: CalculatorViewDelegate {
    func didTapLanguageInCalculatorView() {
        self.advanceToNextInputMode()
    }
    
    func didTapNextKeyboardInCalculatorView() {
        self.calculatorView.removeFromSuperview()
        loadInterface(type: .Basic)
    }
}

extension KeyboardViewController: OneHandViewDelegate {
    func didTapKeyEnter() {
        self.dismissKeyboard()
    }
    
    func didTapKeyLeft() {
        self.oneHandView.removeFromSuperview()
        loadInterface(type: .OneHandLeft)
    }
    
    func didTapKeyRight() {
        self.oneHandView.removeFromSuperview()
        loadInterface(type: .OneHandRight)
    }
    
    func didTapKeyBasic() {
        self.oneHandView.removeFromSuperview()
        loadInterface(type: .Basic)
    }
    
    func didTapKeyLanguage() {
        self.advanceToNextInputMode()
    }
}
