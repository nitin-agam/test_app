//
//  FeedDataSource.swift
//  TestApp
//
//  Created by Nitin A on 04/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

class FeedDataSource {
    
    func fetchFeed(completion: @escaping (()->())) {
        if let factUrl = URL(string: NetworkKeys.facts) {
            var urlRequest = URLRequest(url: factUrl)
            urlRequest.httpMethod = "GET"
            NetworkManager.shared.sendRequest(request: urlRequest) { (result, error) in
                completion()
            }
        }
    }
}
