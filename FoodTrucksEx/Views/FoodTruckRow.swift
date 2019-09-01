//
//  FoodTruckRow.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/28/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import SwiftUI

struct FoodTruckRow: View {
    
    var foodTruck: FoodTruckViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(foodTruck.applicant )
                    .font(.title)
                    .minimumScaleFactor(0.5)
                Text(foodTruck.location)
                    .fontWeight(Font.Weight.light)
                Text(foodTruck.descr)
                    .fontWeight(Font.Weight.thin)
                    .minimumScaleFactor(0.5)
                    //.multilineTextAlignment(.center)
            }.padding()

            Text(foodTruck.operationHours)
            .padding()
            
        }
    }
}

//struct FoodTruckRow_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodTruckRow(foodTruck: FoodTruckViewModel(foodTruck: FoodTruck()))
//    }
//}
