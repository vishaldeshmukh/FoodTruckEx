//
//  MapLayout.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/29/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import SwiftUI
import MapKit


struct MapLayout: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    //@ObservedObject var foodTruckVM: FoodTruckListViewModel
    var foodTruckVM: FoodTruckListViewModel
    var filteredFoodTruck: FoodTruckViewModel!
    @Binding var isPresented: Bool

    @State var selectedFoodTruck: SelectFoodTruck?
    @State var userLocation: CLLocationCoordinate2D?

    var body: some View {
            VStack {
                MapView(foodTruckVM: self.foodTruckVM, filteredFoodTruck: self.filteredFoodTruck, selectedFoodTruck: $selectedFoodTruck, userLocation: $userLocation)
                    .edgesIgnoringSafeArea(.top)
                    .padding()
                if selectedFoodTruck != nil {
                    FoodTruckDetail(selectedFoodTruck: $selectedFoodTruck,userLocation: $userLocation)
                }
            }
            .multilineTextAlignment(.leading)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("List")
            }
        )
    }
}

//struct MapLayout_Previews: PreviewProvider {
//    static var previews: some View {
//        MapLayout(applicant: "applicant", location: "location", descr: "descr", operationHours: "operationHours")
//    }
//}
