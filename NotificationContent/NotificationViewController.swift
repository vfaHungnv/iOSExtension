//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by HungNV on 3/31/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import AVKit
import AVFoundation

private enum NotificationType: UInt8 {
    case Image = 0
    case Gif = 1
    case Video = 2
}

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.indicator.hidesWhenStopped = true
    }
    
    func didReceive(_ notification: UNNotification) {
        let userInfo = notification.request.content.userInfo as! [String:AnyObject]
        let type = userInfo["type"] as! NSNumber
        let notificationType = NotificationType(rawValue: type.uint8Value)!
        
        switch notificationType {
        case .Image:
            let imageView = UIImageView()
            self.view.addSubview(imageView)
            
            self.requestData(url: userInfo["attachment-url"] as! String, completionHandler: { (data:Data?) in
                if data == nil {
                    imageView.image = #imageLiteral(resourceName: "no_image")
                    imageView.frame = CGRect(x: 100, y: 50, width: 126, height: 100)
                } else {
                    let image = UIImage(data: data!)
                    let size = self.scaleSize(image: image!)
                    
                    imageView.image = image
                    imageView.frame = CGRect(x: (320 - size.width) / 2, y: (200 - size.height) / 2, width: size.width, height: size.height)
                }
                self.indicator.stopAnimating()
            })
            break
            
        case .Gif:
            let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 320, height: 200))
            self.view.addSubview(webView)
            let url = userInfo["attachment-url"] as! String
            
            self.requestData(url: url, completionHandler: { (data:Data?) in
                if data == nil {
                    webView.loadHTMLString("can't download", baseURL: nil)
                }
                else {
                    webView.load(data!, mimeType: "image/gif", textEncodingName: String(), baseURL: URL(string: url)!)
                }
                webView.isUserInteractionEnabled = false;
                
                self.indicator.stopAnimating()
            })
            break
            
        case .Video:
            let url = userInfo["attachment-url"] as! String
            let videoURL = NSURL(string: url)
            let player = AVPlayer(url: videoURL! as URL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
            
            self.indicator.stopAnimating()
            break
        }
    }
    
    private func requestData(url:String, completionHandler:@escaping (Data?) -> Swift.Void) {
        do {
            let data = try Data(contentsOf: URL(string: url)!)
            completionHandler(data)
        }
        catch {
            completionHandler(nil)
        }
    }
    
    private func scaleSize(image:UIImage) -> CGSize {
        var size = image.size as CGSize
        
        let sw = 320.0 / size.width
        let sh = 200.0 / size.height
        
        let ss = min(sw, sh)
        
        size.width /= ss
        size.height /= ss
        
        return size
    }
}
