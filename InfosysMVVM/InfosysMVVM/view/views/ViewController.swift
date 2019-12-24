//
//  ViewController.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/23/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import UIKit
import SVPullToRefresh

class ViewController: UIViewController {
    
    //MARK:- Outlet and iVar
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel: TableViewModel = {
        return TableViewModel()
    }()
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewModel()
        self.addPullWithTable()
        self.title = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destinationViewController = segue.destination as? DetailViewController {
                let indexPath = self.tableView.indexPathForSelectedRow!
                destinationViewController.detailVM = viewModel.getCellViewModel(at:indexPath)
            }
        }
    }
    
    //MARK:- Init ViewModel
    private func initViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.title = CountryData.shared.title
                self?.tableView.pullToRefreshView.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        viewModel.initFetchData()
    }
    
    //MARK:- Pull to refresh and load more
    private func addPullWithTable() {
        tableView.addPullToRefresh {
            self.initViewModel()
        }
        tableView.showsInfiniteScrolling = false
    }
    
    //MARK:- IBActions
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        self.initViewModel()
    }
    
    
}

//MARK:- TableView Delegate DataSource
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

