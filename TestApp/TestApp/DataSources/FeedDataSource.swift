//
//  FeedDataSource.swift
//  TestApp
//
//  Created by Nitin A on 04/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

class FeedDataSource {
    
    var factListViewModel: FactListViewModel?
    
    func fetchFeed(completion: @escaping ((Bool)->())) {
        if let factUrl = URL(string: NetworkKeys.facts) {
            var urlRequest = URLRequest(url: factUrl)
            urlRequest.httpMethod = "GET"
            NetworkManager.shared.sendRequest(request: urlRequest) { (result, error) in
                if let data = result {
                    do {
                        self.factListViewModel = try JSONDecoder().decode(FactListViewModel.self, from: data)
                        
                        // filter data before display it to the controller
                        self.factListViewModel?.filterData()
                        completion(true)
                    } catch {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            }
        }
    }
}

struct FactListViewModel: Decodable {
    
    var title: String?
    var facts: [FactModel] = []
    
    private enum CodingKeys: String, CodingKey {
        case title
        case facts = "rows"
    }
    
    mutating func filterData() {
        // filter out the objects which does not contain any information to display
        facts = facts.filter { (model) -> Bool in
            
            // if any one information is available to display, then it will going to add in array
            
            if let title = model.title, title.isEmpty == false {
                return true
            }
            
            if let description = model.description, description.isEmpty == false {
                return true
            }
            
            if let imageHref = model.imageHref, imageHref.isEmpty == false {
                return true
            }
            
            return false
        }
    }
}
