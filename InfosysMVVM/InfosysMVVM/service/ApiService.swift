//
//  ApiService.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/23/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService {
    
    init() {}
    
    //MARK:- Fetch Data Api
    func fetchAllCountryInfo(onResult:@escaping (_ isSuccess: Bool, _ repos: [CountryInfo]?, _ error: String?)->()){
        
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                onResult(false, nil, "could not convert data to UTF-8 format")
                return
            }
            var cInfo:[CountryInfo]=[]
            do {
                let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)  as? [String:Any]
                let rows = responseJSONDict?["rows"] as? [[String: Any]] ?? []
                let title = responseJSONDict?["title"] as? String ?? ""
                for idx in 0..<rows.count {
                    let info = rows[idx]
                    let infoTitle = info["title"] as? String ?? ""
                    let infoDesc = info["description"] as? String ?? ""
                    let infoImageHref = info["imageHref"] as? String ?? ""
                    if infoTitle != "" && infoDesc != "" && infoImageHref != "" {
                        cInfo.append(CountryInfo(title: infoTitle , description: infoDesc, imageHref: infoImageHref))
                    }
                }
                CountryData.shared.countryInfo = cInfo
                CountryData.shared.title = title
                onResult(true, cInfo, nil)
            } catch {
                print(error)
                print("There is some issue to parse data")
                onResult(false, nil, "There is some issue to parse data")
            }
            
        }).resume()
        
        
        
    }
    
}
