//
//  TableViewDataSource.swift
//  TestApp
//
//  Created by Nitin A on 05/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

// custom data source for a table view to reduce code redundancy.
class TableDataSource<CellType, DataModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    // MARK: - Properties
    private let cellIdentifier: String
    private var items: [DataModel]
    private let configureCell: (CellType, DataModel) -> ()
    
    
    // MARK: - Initializer
    init(identifier: String, items: [DataModel], configure: @escaping (CellType, DataModel) -> ()) {
        self.cellIdentifier = identifier
        self.items = items
        self.configureCell = configure
    }
    
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        items.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell with identifier \(cellIdentifier) not found...")
        }
        self.configureCell(cell, self.items[indexPath.row])
        return cell
    }
}


