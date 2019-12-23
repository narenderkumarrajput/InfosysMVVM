//
//  CountryData.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/24/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import Foundation

class CountryData {
    var title: String = ""
    var countryInfo:[CountryInfo] = []
    static let shared = CountryData()
    
    private init(){}
}
