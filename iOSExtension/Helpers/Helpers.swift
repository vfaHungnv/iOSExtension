//
//  Helpers.swift
//  iOSExtension
//
//  Created by HungNV on 3/29/17.
//  Copyright © 2017 HungNV. All rights reserved.
//

import UIKit

class Helpers: NSObject {
    
    class func saveImage(name: String) -> URL? {
        guard let image = UIImage(named: name) else {
            return nil
        }
        let imageData = UIImagePNGRepresentation(image)
        let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        do {
            let imageURL = documentsURL.appendingPathComponent("\(name).png")
            _ = try imageData?.write(to: imageURL)
            return imageURL
        } catch {
            return nil
        }
    }
}
