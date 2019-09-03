//
//  MapViewModel.swift
//  FoodTrucks
//
//  Created by Hai Nguyen on 8/7/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import UIKit
import MapKit

protocol MapTapProtocol {
    func mapDidTapLocation(foodTruck : FoodTruckViewModel)
}
class PinFoodTrucksLocation : NSObject , MKAnnotation {
    let title: String?
    let locationName: String
    var coordinate: CLLocationCoordinate2D
    var pinText: String!
    var foodTruck: FoodTruckViewModel?

    enum type : String {
        case good, bad
    }
    
    let color: UIColor = UIColor.blue
    init(foodTruck: FoodTruckViewModel, coordinate: CLLocationCoordinate2D) {
        
        self.title = foodTruck.applicant
        //if firsLocation {
        self.locationName = foodTruck.location
        self.coordinate = coordinate
        self.foodTruck = foodTruck

        super.init()
    }
    
    func mapItem() -> MKMapItem
    {
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    var subtitle: String? {
        return locationName
    }
    
}

class MapModelView:NSObject, MKMapViewDelegate {
    
    let mapView: MKMapView!
    var lat: CLLocationDegrees = 0
    var long: CLLocationDegrees = 0
    var delegate: MapTapProtocol!
    var selectedFoodTruck: PinFoodTrucksLocation?
    
    // Default view
    var spanX: CLLocationDegrees = 0.5
    var spanY: CLLocationDegrees = 0.5
    
    init(_ map : MKMapView,_ screenSize: CGRect){
        mapView = map
        super.init()
        self.mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let ann = view.annotation
        self.spanY = mapView.region.span.latitudeDelta
        self.spanX = mapView.region.span.longitudeDelta
        
        if (ann is PinFoodTrucksLocation) {
            let currAnn = ann as! PinFoodTrucksLocation
            self.selectedFoodTruck = currAnn
            DispatchQueue.main.async() { () -> Void in

                if self.delegate != nil {
                    self.delegate.mapDidTapLocation(foodTruck: currAnn.foodTruck!)
                }
            }
        }
    }
    
    private func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
    {
        let ann = view.annotation
        
        if (ann is PinFoodTrucksLocation) {
            let currAnn = ann as! PinFoodTrucksLocation
            delegate.mapDidTapLocation(foodTruck: currAnn.foodTruck!)
            self.selectedFoodTruck = currAnn
        }
    }
    func drawDrivingDirection(destinationAddress: String, destinationLocation : CLLocationCoordinate2D ) {
        
        let sourceLocation = CLLocationCoordinate2D(latitude: self.lat,longitude: self.long)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
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
        let coordinateStart = CLLocationCoordinate2DMake(self.lat,self.long)
        let mapItemStart = MKMapItem(placemark: MKPlacemark(coordinate: coordinateStart, addressDictionary:nil))
        mapItemStart.name = "Start location"
        
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation, addressDictionary:nil))
        mapItem.name = destinationAddress //"Target location"
        
        MKMapItem.openMaps(with: [mapItemStart,mapItem], launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
    }
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        let test = MKClusterAnnotation(memberAnnotations: memberAnnotations)
        test.title = ""
        test.subtitle = nil
        return test
    }
}

