//
//  Utility.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/24/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    class func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
}
 
