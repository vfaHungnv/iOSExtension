//
//  HomeViewController.swift
//  iOSExtension
//
//  Created by HungNV on 3/24/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var btnCustomKeyboard: UIButton!
    @IBOutlet weak var btnLocalPushNoti: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBorderButton(btn: btnCustomKeyboard, isCircle: false)
        setBorderButton(btn: btnLocalPushNoti, isCircle: false)
    }
    
    @IBAction func actCustomKeyboard(_ sender: Any) {
        let keyboardVC = self.storyboard?.instantiateViewController(withIdentifier: "keyboardVC") as! CustomKeyboardViewController
        self.navigationController?.pushViewController(keyboardVC, animated: true)
    }
    
    @IBAction func actLocalPushNotification(_ sender: Any) {
        let localPushNotiVC = self.storyboard?.instantiateViewController(withIdentifier: "localPushNotiVC") as! LocalPushViewController
        self.navigationController?.pushViewController(localPushNotiVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
