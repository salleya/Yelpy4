//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        let apikey = "04xem-7qB0W84jZs9uTYDsTUZj3gLJPthl5yi5IXqo_D0oLQ1He4ImOB5D5G3Vm9G9yGQ7V1YrfMewnqcrhFw5GgotlPjOMGUZ-P0ikPehTd5Y9IVA_NVLRreQJtX3Yx"
        
        // Coordinates for Denver
        let lat = 39.7392
        let long = -104.9903
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
        

                // ––––– TODO: Get data from API and return it using completion
                print(data)
                // 1. Convert json response to a dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // 2. Grab the businesses data and convert it to an array of dictionaries for each restaurant
                let restaurants = dataDictionary["businesses"] as! [[String: Any]]
                
                // 3. Completion is an escaping method which allows the data to be used outside of the closure
                
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    }

    
