//
//  FeedController.swift
//  TestApp
//
//  Created by Nitin A on 04/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class FeedController: UIViewController {

    // MARK: - Variables
    private var dataSource = FeedDataSource()
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
        
        dataSource.fetchFeed { (isSuccess) in
            if isSuccess {
                
            }
        }
    }

}
