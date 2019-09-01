//
//  DrivingLocation.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 9/1/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import SwiftUI
import MapKit

struct DrivingLocation: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
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

struct DrivingLocation_Previews: PreviewProvider {
    static var previews: some View {
        DrivingLocation()
    }
}
