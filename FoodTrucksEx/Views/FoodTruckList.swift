//
//  FoodTruckList.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/28/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import Combine
import SwiftUI
import MapKit

//final class FoodTruckData: ObservableObject  {
//    @Published var selectedTruck = FoodTruckViewModel(foodTruck:nil)
//}
final class SelectFoodTruck: ObservableObject {
    @Published var applicant: String = ""
    @Published var location: String = ""
    @Published var descr: String = ""
    @Published var operationHours: String = ""
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227)
}
struct FoodTruckList: View {
    
    @ObservedObject var foodTruckVM: FoodTruckListViewModel = FoodTruckListViewModel()
    //@State var foodTruckVM: FoodTruckListViewModel = FoodTruckListViewModel()

    @State private var showingMapView = false
    @State var searchQuery: String = ""
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading)
                    TextField("Search", text: $searchQuery)
                        .padding()
                    //.keyboardType(.alphabet)
                    
                }
                .border(Color.secondary, width: 1)
                .padding()
//                List{
//                    //ForEach(foodTruckVM.foodTrucks) { foodTruck in
//                        // Not sure if the `if workoutFilter.isOn` is allowed, so I've instead used it to only iterate an empty array
//                        ForEach(self.foodTruckVM.foodTrucks.filter { foodTruckFilter in
//                            foodTruckFilter.applicant.contains(self.searchQuery)
//                        }) { foodTruck in
//                            FoodTruckRow(foodTruck: foodTruck)
//                        }
//                    //}
//                }
                List(foodTruckVM.foodTrucks) { foodTruck in
                    FoodTruckRow(foodTruck: foodTruck)
                }
           }
            .navigationBarTitle("Food Trucks", displayMode: .inline)
            .multilineTextAlignment(.leading)
            .navigationBarItems(trailing:
                NavigationLink(destination: MapLayout(foodTruckVM: self.foodTruckVM, isPresented: self.$showingMapView)) {
                    Text("Map")
                })
//            Button(action: {
//                //self.showingMapView = true
//                self.showingMapView = true
//            }) {
//                Text("Map")
//            }
//            .sheet(isPresented: $showingMapView){
//                //ViewControllerWrapper()
//                //ButtonContentView()
//                MapLayout(foodTruckVM: self.foodTruckVM, isPresented: self.$showingMapView)
//
//                }
//            )
        }
        
        
    }
    
}

struct FoodTruckList_Previews: PreviewProvider {
    static var previews: some View {
        FoodTruckList()
    }
}
