//
//  NetworkManager.swift
//  TestApp
//
//  Created by Nitin A on 04/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation
import Alamofire

// you can print all the logs on console by controlling this constant.
let kAPILogEnabled = true

public class NetworkManager {
    
    static let shared = NetworkManager()
    
    var networkAvailable: Bool {
        NetworkReachabilityManager()?.isReachable == true
    }
    
    func sendRequest(request: URLRequest,
                     completion: @escaping (_ data: Data?, _ error: Error?) -> ()) -> Void {
        
        if self.networkAvailable {
            
            if kAPILogEnabled {
                print("network_manager: URL String: \(String(describing: request.url?.absoluteString)) and parameters: \(String(describing: request.httpBody))")
            }
            
            AF.request(request).responseJSON(completionHandler:
                { (DataResponse) in
                    guard let data = DataResponse.data else {
                        completion(nil, nil)
                        return
                    }
                    
                    let formattedData = self.formatData(data: data)
                    
                    if kAPILogEnabled {
                        print("network_manager: URL String: \(String(describing: request.url?.absoluteString)) and response: \(String(describing: formattedData))")
                    }
                    completion(formattedData, nil)
            })
            
        } else {
            completion(nil, nil)
        }
    }
    
    // MARK: - Private Method
    private func formatData(data: Data) -> Data? {
        if let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) {
            return (Data(utf8Data))
        }
        return (nil)
    }
}

