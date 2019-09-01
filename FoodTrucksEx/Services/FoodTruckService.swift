//
//  FoodTruckService.swift
//  FoodTrucks
//
//  Created by Hai Nguyen on 8/5/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import Foundation

class FoodTruckService {
    
    //https://data.sfgov.org/resource/jjew-r69b.json
    
    func fetchFoodTrucks( completion: @escaping([FoodTruck]?) -> Void) {
        
        let urlStr = "https://data.sfgov.org/resource/jjew-r69b.json"
        
        let headers = [
            "cache-control": "no-cache",
            "Postman-Token": "9a539bf9-80ee-4c17-8183-b0e99912bca2"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: urlStr)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if (error != nil) {
                completion(nil)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                do {
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode([FoodTruck].self, from: data)
                    completion(decoded)
                } catch {
                    // Something was wrong with the response such that it could not be decoded.
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        })
        
        dataTask.resume()
        
    }
    func fetchFoodTrucksLocal(completion: @escaping([FoodTruck]?) -> Void) {
        guard let path = Bundle.main.path(forResource: "foodtrucks", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([FoodTruck].self, from: data)
            completion(decoded)
        } catch {
            completion(nil)
        }
    }
}
