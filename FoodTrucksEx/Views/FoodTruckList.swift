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
                    Spacer()
                    Button(action: {
                        self.searchQuery = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.secondary)
                    }.padding()
                }
                .border(Color.secondary, width: 1)
                .padding()
                if self.searchQuery.isEmpty {
                    List(foodTruckVM.foodTrucks) { foodTruck in
                        NavigationLink(destination: MapLayout(foodTruckVM: self.foodTruckVM,filteredFoodTruck: foodTruck, isPresented: self.$showingMapView)) {
                            FoodTruckRow(foodTruck: foodTruck)
                        }
                    }
                } else {
                    List{
                        ForEach(self.foodTruckVM.foodTrucks.filter { foodTruckFilter in
                            foodTruckFilter.applicant.contains(self.searchQuery) || foodTruckFilter.descr.contains(self.searchQuery)
                        }) { foodTruck in
                            
                            NavigationLink(destination: MapLayout(foodTruckVM: self.foodTruckVM, filteredFoodTruck:foodTruck,  isPresented: self.$showingMapView)) {
                                FoodTruckRow(foodTruck: foodTruck)
                            }
                        }
                    }
                }
           }
            .navigationBarTitle("Food Trucks", displayMode: .inline)
            .multilineTextAlignment(.leading)
            .navigationBarItems(trailing:
                NavigationLink(destination: MapLayout(foodTruckVM: self.foodTruckVM, isPresented: self.$showingMapView)) {
                    Text("Map")
                })
        }
        
        
    }
    
}

struct FoodTruckList_Previews: PreviewProvider {
    static var previews: some View {
        FoodTruckList()
    }
}
