//
//  ApiServiceTest.swift
//  InfosysMVVMTests
//
//  Created by Narender Kumar on 12/24/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import XCTest
@testable import InfosysMVVM

class ApiServiceTest: XCTestCase {

    var apiService:ApiService?
    
    override func setUp() {
        super.setUp()
        apiService = ApiService()
    }
    
    override func tearDown() {
        apiService=nil
        super.tearDown()
    }
    
    func testApiService(){
        let apiCall = self.apiService!
        let expect = XCTestExpectation(description: "callback")
        
        apiCall.fetchAllCountryInfo{ (isSuccess, dataArray, error) in
            expect.fulfill()
            //XCTAssertEqual( dataArray?.count, 5)
            for data in dataArray ?? [] {
                XCTAssertNotNil(data.title)
                XCTAssertNotNil(data.description)
                XCTAssertNotNil(data.imageHref)
            }
        }
        
        wait(for: [expect], timeout: 30.0)
    }
    
}
