//
//  DetailViewTest.swift
//  InfosysMVVMTests
//
//  Created by Narender Kumar on 12/24/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import XCTest
@testable import InfosysMVVM

class DetailViewTest: XCTestCase {
    
    var vm: CellViewModel?
    
    override func setUp() {
        vm = CellViewModel( title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        
    }
    
    func testSetupUI() {
        XCTAssertNotNil(vm?.title)
        XCTAssertNotNil(vm?.description)
        XCTAssertNotNil(vm?.imageHref)
    }
    
    override func tearDown() {
        
    }
    
}
