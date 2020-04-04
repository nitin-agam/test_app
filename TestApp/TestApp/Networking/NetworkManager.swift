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
    func sendRequest(request: URLRequest,
                     completion: @escaping (_ result: Any?, _ error: Error?) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            if kAPILogEnabled {
                print("network_manager: URL String: \(String(describing: request.url?.absoluteString)) and parameters: \(String(describing: request.httpBody))")
            }
            
            AF.request(request).responseJSON(completionHandler:
                { (DataResponse) in
                    guard let data = DataResponse.data else { return }
                    let json = self.jsonFromData(data: data)
                    
                    if kAPILogEnabled {
                        print("network_manager: URL String: \(String(describing: request.url?.absoluteString)) and response: \(String(describing: json.responseData))")
                    }
                    completion(json.responseData, json.error)
            })
            
        } else {
            completion(nil, nil)
        }
    }
    
    // MARK: - Private Method
    private func jsonFromData(data: Data) -> (responseData: Any?, error: Error?) {
        if let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) {
            do {
                let dataObject = Data(utf8Data)
                let responseData = try JSONSerialization.jsonObject(with: dataObject,
                                                                    options: .allowFragments)
                return (responseData, nil)
            } catch let error {
                return (nil, error)
            }
        }
        return (nil, nil)
    }
}

