//
//  FoodTruckViewModel.swift
//  FoodTrucks
//
//  Created by Hai Nguyen on 8/6/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import UIKit
import MapKit

class FoodTruckViewModel: Identifiable {
//    static func == (lhs: FoodTruckViewModel, rhs: FoodTruckViewModel) -> Bool {
//        return true
//    }
    
    
    let id = UUID()

    var foodTruck: FoodTruck?
    
    init(foodTruck: FoodTruck?) {
        if let foodTruck = foodTruck {
            self.foodTruck = foodTruck
        } 
    }
    
    var applicant: String {
        return foodTruck?.applicant ?? ""
    }
    var location: String {
        return foodTruck?.location?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    var descr: String {
        return foodTruck?.optionaltext ?? ""
    }
    
    var coordinates: [CLLocationCoordinate2D] {
        
        var latlongs: [CLLocationCoordinate2D] = []
        latlongs.append(CLLocationCoordinate2D(latitude: Double(foodTruck?.latitude ?? "0")!,longitude: Double(foodTruck?.longitude ?? "0")!))
        if hasSecondLocation {
            latlongs.append(CLLocationCoordinate2D(latitude: Double(foodTruck?.location_2.latitude ?? "0")!,longitude: Double(foodTruck?.location_2.longitude ?? "0")!))
        }
        return latlongs
    }
    
//    var latitude: String {
//        return foodTruck?.latitude ?? ""
//    }
//    var longitude: String {
//        return foodTruck?.longitude ?? ""
//    }
//
//    var latitude2: String {
//        return foodTruck?.location_2.latitude ?? ""
//    }
//    var longitude2: String {
//        return foodTruck?.location_2.longitude ?? ""
//    }
    
    var operationHours: String {
        return "\(foodTruck?.starttime ?? "") - \(foodTruck?.endtime ?? "")"
    }
    
    var hasSecondLocation: Bool {
        return (foodTruck?.location_2.latitude?.count ?? 0 > 0 && foodTruck?.location_2.longitude?.count ?? 0 > 0)
    }
    
    var dayofweekstr: String {
        return foodTruck?.dayofweekstr ?? ""
    }
    
    var end24: String {
        return foodTruck?.end24 ?? ""
    }
    
    var start24: String {
        return foodTruck?.start24 ?? ""
    }
}
