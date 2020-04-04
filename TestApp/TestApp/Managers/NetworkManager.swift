//
//  NetworkManager.swift
//  TestApp
//
//  Created by Nitin A on 04/04/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation
import Alamofire

let kAPILogEnabled = true

enum kHTTPMethod: String {
    case GET, POST
}

public class NetworkManager {
    
    static let shared = NetworkManager()
    
    // MARK: - Public Methods
    
    // This moethod is used to send request for every type of HTTP methods.
    func sendRequest(urlString: String,
                     method: kHTTPMethod,
                     parameters: Dictionary<String, Any>,
                     completion: @escaping (_ result: Any?, _ error: Error?) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            if kAPILogEnabled {
                print("network_manager: URL String: \(urlString) and parameters: \(parameters)")
            }
            
            switch method {
            case .GET:
                AF.request(urlString,
                           method: .get,
                           parameters: parameters,
                           encoding: URLEncoding.default,
                           headers: [:]).responseJSON(completionHandler:
                            { (DataResponse) in
                                switch DataResponse.result {
                                case .success(let JSON):
                                    if kAPILogEnabled {
                                        print("network_manager: URL String: \(urlString) and json repsonse: \(JSON)")
                                    }
                                    let response = self.getResponseFromData(data: DataResponse.data!)
                                    completion(response.responseData, response.error)
                                    
                                case .failure(let error):
                                    if kAPILogEnabled {
                                        print("network_manager: URL String: \(urlString) and json error: \(error.localizedDescription)")
                                    }
                                    completion(nil, error)
                                }
                           })
            default:
                completion(nil, nil)
                // implement other request methods like post, delete etc as per the requirement...
            }
        } else {
            completion(nil, nil)
        }
    }
    
    
    // MARK: - Private Method
    private func getResponseFromData(data: Data) -> (responseData: Any?, error: Error?) {
        do {
            let responseData = try JSONSerialization.jsonObject(with: data,
                                                                options: .allowFragments)
            return (responseData, nil)
        } catch let error {
            return (nil, error)
        }
    }
}

