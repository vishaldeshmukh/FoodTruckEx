//
//  ContentView.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/27/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
        
    @State var model = FoodTruckListViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Text("test")
                
                List(model.foodTrucks) { foodTruck in
                    //NavigationButton(destination: Text(foodTruck.applicant)) {
                    //NavigationLink(destination:FoodTruckDetail(selectedFoodTruck) {
                        FoodTruckRow(foodTruck: foodTruck)
                    //}
                }
                    //}
                    .navigationBarTitle(Text("Food Trucks"))
                    .navigationBarItems(
                        trailing: Button(action: showMap, label: { Text("Map") }))

            }
        }
        
    }
    func showMap() {

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
