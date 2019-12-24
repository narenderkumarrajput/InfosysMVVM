//
//  CountryInfoTableViewCellViewModel.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/23/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import Foundation
import UIKit

public typealias ImageDownloadCompletionClosure = (_ imageData: NSData ) -> Void

class CountryInfoTableViewCellViewModel {

    let title:String?
    let description:String?
    let imageHref:String?
    
    init(title:String, description:String, imageHref:String) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
        
    func download(completionHanlder: @escaping ImageDownloadCompletionClosure)  {
        if Utility.verifyUrl(urlString: imageHref) {
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            let request = URLRequest(url:URL(string: imageHref!)!)
            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
                
                if let tempLocalUrl = tempLocalUrl, error == nil {
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        let rawImageData = NSData(contentsOf: tempLocalUrl)
                        completionHanlder(rawImageData!)
                        print("Image Download \(statusCode)")
                    }
                } else {
                    print("Error in image download \(String(describing: error?.localizedDescription))")
                }
            }
            task.resume()
        }
        
    }
    
}
