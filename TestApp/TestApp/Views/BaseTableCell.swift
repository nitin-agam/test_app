//
//  BaseTableCell.swift
//  TestApp
//
//  Created by Nitin A on 05/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

// create a subclass of "BaseTableCell" to get the basic customization for a table cell.
class BaseTableCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialSetup() {
        selectionStyle = .none
        backgroundColor = .clear
    }
}
