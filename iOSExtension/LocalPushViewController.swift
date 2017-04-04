//
//  LocalPushViewController.swift
//  iOSExtension
//
//  Created by HungNV on 3/24/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit
import UserNotifications
import AVKit
import AVFoundation

class LocalPushViewController: UIViewController {

    @IBOutlet weak var btnSimplePush: UIButton!
    @IBOutlet weak var btnCustomAction: UIButton!
    @IBOutlet weak var btnCustomContent: UIButton!
    @IBOutlet weak var btnMediaPush: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorderButton(btn: btnSimplePush, isCircle: false)
        setBorderButton(btn: btnCustomAction, isCircle: false)
        setBorderButton(btn: btnCustomContent, isCircle: false)
        setBorderButton(btn: btnMediaPush, isCircle: false)
    }
    
    @IBAction func actSimplePush(_ sender: Any) {
        let content = ExtensionNotificationContent(title: "Title: Local notifications", subTitle: "SubTitle:", body: "Body: Simple push")
        let center = UNUserNotificationCenter.current()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: Defines.requestIdentifier, content: content, trigger: trigger)
        center.delegate = self
        center.add(request) { error in
            if (error != nil) {}
        }
    }
    
    @IBAction func actCustomAction(_ sender: Any) {
        let content = ExtensionNotificationContent(title: "Title: Local notifications", subTitle: "SubTitle:", body: "Body: Custom action")
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let commentAction = UNTextInputNotificationAction(identifier: "Comment", title: "Add Comment", options: [], textInputButtonTitle: "Add", textInputPlaceholder: "Add Comment Here")
        let deleteAction = UNNotificationAction(identifier: "UYLDeleteAction", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: "UYLCategoryIdentifier", actions: [snoozeAction, commentAction, deleteAction], intentIdentifiers: [], options: [])
        content.categoryIdentifier = "UYLCategoryIdentifier"
        
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        let request = UNNotificationRequest(identifier: Defines.customActionIdentifier, content: content, trigger: nil)
        center.delegate = self
        center.add(request) { error in
            if (error != nil) {}
        }
    }
    
    @IBAction func actCustomContent(_ sender: Any) {
        let content = ExtensionNotificationContent(title: "Title: Local notifications", subTitle: "SubTitle:", body: "Body: Custom content")
        guard let url = Helpers.saveImage(name: "nice_final_cover.jpg") else {
            return
        }
        
        let attachment = try? UNNotificationAttachment(identifier: Defines.customContentIdentifier, url: url, options: [:])
        
        if let attachment = attachment {
            content.attachments.append(attachment)
        }
        
        let request = UNNotificationRequest(identifier: Defines.customContentIdentifier, content: content, trigger: nil)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.add(request) { error in
            if (error != nil) {}
        }
    }
    
    @IBAction func actMedia(_ sender: Any) {
        let content = ExtensionNotificationContent(title: "Title: Local notifications", subTitle: "SubTitle:", body: "Body: Custom media")
        
        content.categoryIdentifier = Defines.mediaIdentifier
        content.userInfo = [
            "aps":[
                "alert":[
                    "title":"Local notifications",
                    "subtitle":"Push video",
                    "body":"Pull down to get more"
                ],
                "category":"CustomNotification",
                "mutable-content":1
            ],
            "data":[
                "type":2,
                "my-attachment":"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
            ]
        ]
        
        let request = UNNotificationRequest(identifier: Defines.mediaIdentifier, content: content, trigger: nil)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.add(request) { error in
            if (error != nil) {}
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIViewController: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        completionHandler( [.alert, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        
        switch response.notification.request.identifier {
        case Defines.requestIdentifier:
            print(Defines.requestIdentifier)
            break
            
        case Defines.customActionIdentifier:
            print(Defines.customActionIdentifier)
            
            switch response.actionIdentifier {
            case "Snooze":
                print("Snooze")
                break
            case "Delete":
                print("Delete")
                break
            case "Comment":
                let textResponse = response as! UNTextInputNotificationResponse
                print("Comment \(textResponse.userText)")
                
                let alert = UIAlertController(title: "Comment", message: textResponse.userText, preferredStyle: .alert)
                let act = UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
                })
                alert.addAction(act)
                UIApplication.shared.windows[0].rootViewController?.present(alert, animated: true, completion: {})
                
                break
            default:
                break
            }
            
        case Defines.customContentIdentifier:
            print(Defines.customContentIdentifier)
            break
            
        case Defines.mediaIdentifier:
            print(Defines.mediaIdentifier)
            let userInfo:[String:AnyObject] = response.notification.request.content.userInfo as! [String:AnyObject]
            let url = userInfo["data"]!["my-attachment"] as! String
            let videoURL = NSURL(string: url)
            let player = AVPlayer(url: videoURL! as URL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
            break
            
        default:
            break
        }
        completionHandler()
    }
}

final class ExtensionNotificationContent: UNMutableNotificationContent {
    init(title: String, subTitle: String, body: String) {
        super.init()
        self.title = title
        self.subtitle = subTitle
        self.body = body
        self.sound = UNNotificationSound.default()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Defines {
    static let requestIdentifier        = "RequestIdentifier"
    static let customActionIdentifier   = "CustomActionIdentifier"
    static let customContentIdentifier  = "CustomContentIdentifier"
    static let mediaIdentifier          = "MediaIdentifier"
}

/*
 |_Notification
    |_RequestIdentifier 1
        |_CategoryIdentifier 1
            |_ActionIdentifier 1
            |_ActionIdentifier 2
                ...
        |_CategoryIdentifier 2
            |_ActionIdentifier 1
            |_ActionIdentifier 2
                ...
    |_RequestIdentifier 2
        ...
 */


