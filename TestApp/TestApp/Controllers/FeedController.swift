//
//  FeedController.swift
//  TestApp
//
//  Created by Nitin A on 04/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class FeedController: UITableViewController {

    // MARK: - Variables
    private var dataSource = FeedDataSource()
    private var tableDataSource: TableDataSource<FactListTableCell, FactModel>?
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        dataSource.fetchFeed { [weak self] (isSuccess) in
            if let self = self {
                if isSuccess {
                    self.dataSetup()
                    self.navigationTitleSetup()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func navigationTitleSetup() {
        if let title = dataSource.factListViewModel?.title {
            self.title = title
        }
    }
    
    private func dataSetup() {
        if let facts = self.dataSource.factListViewModel?.facts {
            self.tableView.register(FactListTableCell.self, forCellReuseIdentifier: String(describing: FactListTableCell.self))
            self.tableDataSource = TableDataSource(identifier: String(describing: FactListTableCell.self),
                                                   items: facts,
                                                   configure:
                { (cell, factModel) in
                    cell.fact = factModel
            })
            self.tableView.dataSource = self.tableDataSource
            self.tableView.delegate = self
        }
    }
}

// UITableView's Delegates
extension FeedController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if let facts = self.dataSource.factListViewModel?.facts {
//            let factModel = facts[indexPath.row]
//           // let textHeight = Utility.textHeight(width: <#T##CGFloat#>, font: <#T##UIFont#>, text: <#T##String#>)
//        }
//        return UITableView.automaticDimension
        return (UITableView.automaticDimension > 120) ? UITableView.automaticDimension : 120

    }
}
