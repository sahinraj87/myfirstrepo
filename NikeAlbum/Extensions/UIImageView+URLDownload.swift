//
//  UIImageView+URLDownload.swift
//  NikeAlbum
//
//  Created by sahin raj on 2/20/20.
//  Copyright © 2020 sahin raj. All rights reserved.
//

import UIKit


var temp: Double = 10
extension UIImageView {
    
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        
        if let parsedURL = NSURL(string: urlString) {
            
            URLSession.shared.dataTask(with: parsedURL as URL, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    return
                }
                
                if let resultData = data {
                    temp -= 2
                    if(temp <= 0){
                        temp = 10
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + temp, execute: { () -> Void in
                        let image = UIImage(data: resultData)
                        self.image = image
                    })
                }
                
                
            }).resume()
            
        }
        
    }
    
}
