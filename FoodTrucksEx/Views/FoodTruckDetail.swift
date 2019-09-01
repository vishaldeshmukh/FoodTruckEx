//
//  FoodTruckDetail.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/28/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import SwiftUI
import MapKit

struct FoodTruckDetail: View {

    @Binding var selectedFoodTruck: SelectFoodTruck?
    @Binding var userLocation: CLLocationCoordinate2D?

    var applicant: String {
        return selectedFoodTruck?.applicant ?? ""
    }
    var location: String {
        return selectedFoodTruck?.location ?? ""
    }
    var descr: String {
        return selectedFoodTruck?.descr ?? ""
    }
    var operationHours: String {
        return selectedFoodTruck?.operationHours ?? ""
    }
    var coordinate: CLLocationCoordinate2D {
        return (selectedFoodTruck?.coordinate ?? nil)!
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(applicant)
                    .font(.title)
                    .minimumScaleFactor(0.5)
                    
                Text(location)
                    .fontWeight(Font.Weight.light)
                Text(descr)
                    .fontWeight(Font.Weight.thin)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.5)
            }.padding()
            VStack(alignment: .trailing) {
                Image("car")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                    .padding()
                    .onTapGesture {
                        self.drawDrivingDirection(destinationAddress: self.applicant, startingLocation: self.userLocation!, destinationLocation: self.coordinate)
                }
                Text(operationHours)
                    .padding()
            }
        }
    }
    func drawDrivingDirection(destinationAddress: String, startingLocation : CLLocationCoordinate2D, destinationLocation : CLLocationCoordinate2D ) {
        
        //let sourceLocation = CLLocationCoordinate2D(latitude: self.lat,longitude: self.long)
        
        let sourcePlacemark = MKPlacemark(coordinate: startingLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Start"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "End"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        let coordinateStart = CLLocationCoordinate2DMake(startingLocation.latitude,startingLocation.longitude)
        let mapItemStart = MKMapItem(placemark: MKPlacemark(coordinate: coordinateStart, addressDictionary:nil))
        mapItemStart.name = "Start location"
        
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation, addressDictionary:nil))
        mapItem.name = destinationAddress //"Target location"
        
        MKMapItem.openMaps(with: [mapItemStart,mapItem], launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
    }
}

//struct FoodTruckDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodTruckDetail(applicant: "Food Truck", location: "100 Main Street", descr: "Hotdogs and corndogs", operationHours: "6AM - 7PM")
//    }
//}

