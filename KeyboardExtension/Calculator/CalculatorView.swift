//
//  CalculatorView.swift
//  iOSExtension
//
//  Created by HungNV on 3/27/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

protocol CalculatorViewDelegate: class {
    func didTapNextKeyboardInCalculatorView()
    func didTapLanguageInCalculatorView()
}

// Basic math functions
func add(_ a: Double, b: Double) -> Double {
    let result = a + b
    return result
}
func sub(_ a: Double, b: Double) -> Double {
    let result = a - b
    return result
}
func mul(_ a: Double, b: Double) -> Double {
    let result = a * b
    return result
}
func div(_ a: Double, b: Double) -> Double {
    let result = a / b
    return result
}

typealias Binop = (Double, Double) -> Double
let ops: [String: Binop] = [ "+" : add, "-" : sub, "*" : mul, "/" : div ]

class CalculatorView: UIView {
    
    @IBOutlet weak var lblDisplay: UILabel!
    weak var delegate: CalculatorViewDelegate?
    var accumulator: Double = 0.0
    var userInput = ""
    
    var numStack: [Double] = [] // Number stack
    var opStack: [String] = [] // Operator stack
    
    func hasIndex(stringToSearch str: String) -> Bool {
        for ch in str.unicodeScalars {
            if ch == "." {
                return true
            }
        }
        return false
    }
    
    func handleInput(_ str: String) {
        if str == "-" {
            if userInput.hasPrefix(str) {
                // Strip off the first character (a dash)
                userInput = userInput.substring(from: userInput.characters.index(after: userInput.startIndex))
            } else {
                userInput = str + userInput
            }
        } else {
            userInput += str
        }
        accumulator = Double((userInput as NSString).doubleValue)
        updateDisplay()
    }
    
    func updateDisplay() {
        // If the value is an integer, don't show a decimal point
        let iAcc = Int(accumulator)
        if accumulator - Double(iAcc) == 0 {
            lblDisplay.text = "\(iAcc)"
        } else {
            lblDisplay.text = "\(accumulator)"
        }
    }
    
    func doMath(_ newOp: String) {
        if userInput != "" && !numStack.isEmpty {
            let stackOp = opStack.last
            if !((stackOp == "+" || stackOp == "-") && (newOp == "*" || newOp == "/")) {
                let oper = ops[opStack.removeLast()]
                accumulator = oper!(numStack.removeLast(), accumulator)
                doEquals()
            }
        }
        opStack.append(newOp)
        numStack.append(accumulator)
        userInput = ""
        updateDisplay()
    }
    
    func doEquals() {
        if userInput == "" {
            return
        }
        if !numStack.isEmpty {
            let oper = ops[opStack.removeLast()]
            accumulator = oper!(numStack.removeLast(), accumulator)
            if !opStack.isEmpty {
                doEquals()
            }
        }
        updateDisplay()
        userInput = ""
    }
    
    @IBAction func didTapLanguage(_ sender: Any) {
        self.delegate?.didTapLanguageInCalculatorView()
    }
    
    @IBAction func didTapNextKeyboard(_ sender: Any) {
        self.delegate?.didTapNextKeyboardInCalculatorView()
    }
    
    @IBAction func didTapOperation(_ sender: Any) {
        if let op = (sender as AnyObject).titleLabel??.text {
            doMath(op)
        }
    }
    
    @IBAction func didTapNumber(_ sender: Any) {
        if let numberAsString = (sender as AnyObject).titleLabel??.text {
            handleInput(numberAsString)
        }
    }
    
    @IBAction func didTapDot(_ sender: Any) {
        if hasIndex(stringToSearch: userInput) == false {
            handleInput(".")
        }
    }
    
    @IBAction func didTapClear(_ sender: Any) {
        userInput = ""
        accumulator = 0
        updateDisplay()
        numStack.removeAll()
        opStack.removeAll()
    }
    
    @IBAction func didTapEqual(_ sender: Any) {
        doEquals()
    }
    
    @IBAction func didTapCHSPress(_ sender: UIButton) {
        if userInput.isEmpty {
            userInput = lblDisplay.text!
        }
        handleInput("-")
    }
}
