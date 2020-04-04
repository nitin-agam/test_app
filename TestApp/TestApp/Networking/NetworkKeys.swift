//
//  NetworkKeys.swift
//  TestApp
//
//  Created by Nitin A on 04/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

struct NetworkKeys {
    
    static var base: String {
        // here we can customize our base url according to production and staging server...
        "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
    }

    static public let facts = "\(NetworkKeys.base)facts.json"
}

