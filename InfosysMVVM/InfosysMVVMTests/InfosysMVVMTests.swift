//
//  InfosysMVVMTests.swift
//  InfosysMVVMTests
//
//  Created by Narender Kumar on 12/23/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import XCTest
@testable import InfosysMVVM

class InfosysMVVMTests: XCTestCase {
    
    var sut: CountryInfoTableViewModel!
    var mockAPIService: MockApiService!

    override func setUp() {
        mockAPIService = MockApiService()
        sut = CountryInfoTableViewModel(apiService: mockAPIService)
    }

    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testCreateCellViewModel() {
        // Given
        let repos = StubGenerator().stubPhotos()
        mockAPIService.completeRepos = repos
        let expect = XCTestExpectation(description: "reload closure triggered")
        sut.reloadTableViewClosure = { () in
            expect.fulfill()
        }
        
        // When
        sut.initFetchData()
        mockAPIService.fetchSuccess()
        
        // Number of cell view model is equal to the number of photos
        XCTAssertEqual( sut.numberOfCells, repos.count )
        XCTAssertEqual(sut.numberOfCells, 1)
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }
    
    func testCellViewModel() {
        let countryInfo1 = CountryInfo(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        
        let cellViewModel = sut!.createCellViewModel( countryInfo:countryInfo1 )
        
        XCTAssertEqual( countryInfo1.title, cellViewModel.title )
        XCTAssertEqual( countryInfo1.imageHref, cellViewModel.imageHref )
        XCTAssertEqual(countryInfo1.description, cellViewModel.description)
    }
}

class MockApiService: ApiService {
    var isFetchRepoCalled = false
    var completeRepos: [CountryInfo] = [CountryInfo]()
    var completeClosure: ((Bool, [CountryInfo]?, String?) -> ())!
    
    override
    func fetchAllCountryInfo(onResult: @escaping (Bool, [CountryInfo]?, String?) -> ()) {
        isFetchRepoCalled = true
        completeClosure = onResult
    }
    
    func fetchSuccess() {
        completeClosure(true, completeRepos, nil)
    }
    
    func fetchFail(error:String) {
        completeClosure(false, nil, error)
    }
    
}

class StubGenerator {
     let countryInfo1 = CountryInfo(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
    
    func stubPhotos() -> [CountryInfo] {
        var cInfo:[CountryInfo] = []
        cInfo.append(countryInfo1)
        return cInfo
    }
}
