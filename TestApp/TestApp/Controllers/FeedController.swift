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
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let noDataLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let dataRefreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl(frame: .zero)
        refresher.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refresher
    }()
    
    private var dataSource = FeedDataSource()
    private var tableDataSource: TableDataSource<FactListTableCell, FactModel>?
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        noDataViewSetup()
        fetchData()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.refreshControl = self.dataRefreshControl
        tableView.tableFooterView = UIView()
        
        self.tableView.register(FactListTableCell.self, forCellReuseIdentifier: String(describing: FactListTableCell.self))
        self.tableView.delegate = self
    }
    
    private func noDataViewSetup() {
        view.addSubviews(activityIndicator, noDataLabel)
        activityIndicator.makeConstraints(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        noDataLabel.makeConstraints(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
    }
    
    private func showErrorLabel(message: String?) {
        if let message = message {
            self.noDataLabel.isHidden = false
            self.noDataLabel.text = message
           // self.tableView.isHidden = true
        } else {
            self.noDataLabel.isHidden = true
            self.noDataLabel.text = nil
          //  self.tableView.isHidden = false
        }
    }
    
    private func fetchData() {
        if NetworkManager.shared.networkAvailable {
            self.activityIndicator.startAnimating()
            dataSource.fetchFeed { [weak self] (isSuccess) in
                if let self = self {
                    self.activityIndicator.stopAnimating()
                    if isSuccess {
                        self.dataSourceSetup()
                        self.navigationTitleSetup()
                        DispatchQueue.main.async {
                            self.dataRefreshControl.endRefreshing()
                            self.tableView.reloadData()
                        }
                    } else {
                        self.showErrorLabel(message: "Something went wrong")
                    }
                }
            }
        } else {
            self.dataRefreshControl.endRefreshing()
            self.showErrorLabel(message: "No internet available")
        }
    }
    
    private func navigationTitleSetup() {
        if let title = dataSource.factListViewModel?.title {
            self.title = title
        }
    }
    
    private func dataSourceSetup() {
        if let facts = self.dataSource.factListViewModel?.facts, facts.isEmpty == false {
            self.tableDataSource = TableDataSource(identifier: String(describing: FactListTableCell.self),
                                                   items: facts,
                                                   configure:
                { (cell, factModel) in
                    cell.fact = factModel
            })
            self.tableView.dataSource = self.tableDataSource
        } else {
            self.showErrorLabel(message: "No data available")
        }
    }
    
    @objc private func handleRefreshControl() {
        
        fetchData()
    }
}

// UITableView's Delegates
extension FeedController {
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        if let facts = self.dataSource.factListViewModel?.facts {
////            let factModel = facts[indexPath.row]
////            let textHeight = Utility.textHeight(width: view.frame.width - 186, font: UIFont.systemFont(ofSize: 16), text: factModel.fullText) + 24
////            print("text: \(factModel.title) and height: ", textHeight)
////            return textHeight
////        }
////        return 0
////        return UITableView.automaticDimension
//        if UITableView.automaticDimension > 124 {
//            print("returning auto")
//           return UITableView.automaticDimension
//        } else {
//            print("returning 124: hh: \(UITableView.automaticDimension)")
//            return 124
//        }
//    //    return (UITableView.automaticDimension > 124) ? UITableView.automaticDimension : 124
//
//    }
}
