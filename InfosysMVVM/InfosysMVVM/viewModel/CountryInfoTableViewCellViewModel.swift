//
//  CountryInfoTableViewCellViewModel.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/23/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import Foundation

class CountryInfoTableViewCellViewModel {

    let title:String?
    let description:String?
    let imageHref:String?
    
    init(title:String, description:String, imageHref:String) {
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
    
}
