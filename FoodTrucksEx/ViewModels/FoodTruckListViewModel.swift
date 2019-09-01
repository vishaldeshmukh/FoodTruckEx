//
//  FoodTruckListViewModel.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/28/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import UIKit
import Combine

class FoodTruckListViewModel: ObservableObject {
        
    let objectWillChange = ObservableObjectPublisher() //PassthroughSubject<FoodTruckListViewModel, Never>()
    
    init() {
        fetchFoodTrucks()
    }
    
    @Published var foodTrucks = [FoodTruckViewModel]() {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
        
    var hasFoodTrucks: Bool {
        return (foodTrucks.count > 0)
    }
    
    var foodTruckCount: Int {
        return foodTrucks.count
    }
        
    func fetchFoodTrucks() {
        
        let foodTruckService = FoodTruckService()

        foodTruckService.fetchFoodTrucks() {[weak self] (foodTrucks) in
            
            
            if let foodTrucks = foodTrucks {
                let foodTrucks = foodTrucks.map(FoodTruckViewModel.init)
                self?.filterOpenFoodTrucks(foodTrucks)

            } else {
                foodTruckService.fetchFoodTrucksLocal(completion: { (result) in
                    if let foodTruckResult = result {
                        let foodTrucks = foodTruckResult.map(FoodTruckViewModel.init)
                        self?.filterOpenFoodTrucks(foodTrucks)
                        
                    }
                })

            }
            
        }
    }
    
    func filterOpenFoodTrucks(_ foodTruck: [FoodTruckViewModel]) {
        
        // get current day and filter today only in PDT
        let timeZone = TimeZone(abbreviation: "PDT")!
        let dateComponents = Calendar.current.dateComponents(in: timeZone, from: Date())
        let dayOfTheWeek = dateComponents.date?.dayOfWeek()
        
        let currentHour = dateComponents.calendar?.component(.hour, from: Date())
        let currentMinutes = dateComponents.calendar?.component(.minute, from: Date())
        var endHour = Int(currentHour!)
        if currentMinutes! > 0 {
            endHour += 1
        }
        
        self.foodTrucks = foodTruck.filter{ $0.dayofweekstr == dayOfTheWeek && ($0.start24 as NSString).integerValue <= currentHour! && ($0.end24 as NSString).integerValue >= endHour }
            .sorted(by: {  $0.applicant < $1.applicant })

    }
    
    func searchFoodTrucks(_ searchText: String) -> [FoodTruckViewModel] {
        if searchText.isEmpty {
            return foodTrucks.filter({( foodtruck : FoodTruckViewModel) -> Bool in
                return ((foodtruck.applicant.lowercased().contains(searchText.lowercased())) || ((foodtruck.descr.lowercased()).contains(searchText.lowercased())))
            })
        } else {
            return foodTrucks
        }
    }
}


