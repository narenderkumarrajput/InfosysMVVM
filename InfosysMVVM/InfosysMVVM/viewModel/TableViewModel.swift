//
//  CountryInfoTableViewModel.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/23/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import Foundation

class TableViewModel {
    
    var apiService:ApiService
    private var countryInfo:[CountryInfo] = [CountryInfo]()
    private var cellViewModels:[CellViewModel] = [CellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    var reloadTableViewClosure: (()->())?
    
    
    init(apiService:ApiService = ApiService()) {
        self.apiService=apiService
    }
    
    func initFetchData() {
        apiService.fetchAllCountryInfo { (isSuccess, countryInfoList, errorString) in
            if(isSuccess) {
                if let cInfo = countryInfoList, cInfo.count > 0 {
                    self.processFetchedRepo(countryInfo: countryInfoList!)
                }
            }else{
                print("Error: \(String(describing: errorString))")
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> CellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( countryInfo: CountryInfo ) -> CellViewModel {
        return CellViewModel( title: countryInfo.title ?? "", description: countryInfo.description ?? "", imageHref: countryInfo.imageHref ?? "")
    }
    
    private func processFetchedRepo( countryInfo: [CountryInfo] ) {
        self.countryInfo = countryInfo // Cache
        var vms = [CellViewModel]()
        for repo in countryInfo {
            vms.append( createCellViewModel(countryInfo: repo) )
        }
        self.cellViewModels = vms
    }
    
}
