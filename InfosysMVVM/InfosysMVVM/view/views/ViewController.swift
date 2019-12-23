//
//  ViewController.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/23/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel: CountryInfoTableViewModel = {
        return CountryInfoTableViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    private func initViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.initFetchData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = (self.tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell)!
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.setData(cellVM)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
}

