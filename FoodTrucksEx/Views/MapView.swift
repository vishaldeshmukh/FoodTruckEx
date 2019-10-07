//
//  MapView.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/28/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let locationManager = CLLocationManager()

    class Coordinator: NSObject, MKMapViewDelegate {

         //@ObservedObject var selectedFoodTruck: SelectFoodTruck
         @Binding var selectedFoodTruck: SelectFoodTruck?

//         init(selectedFoodTruck: SelectFoodTruck) {
//            self.selectedFoodTruck = selectedFoodTruck
//         }
        init(selectedFoodTruck: Binding<SelectFoodTruck?>) {
            _selectedFoodTruck = selectedFoodTruck
        }

         func mapView(_ mapView: MKMapView,
                      didSelect view: MKAnnotationView) {
             guard let pin = view.annotation as? PinFoodTrucksLocation else {
                 return
             }
             //pin.action?()
            let sel = SelectFoodTruck()
            sel.applicant = pin.foodTruck?.applicant ?? ""
            sel.descr = pin.foodTruck?.descr ?? ""
            sel.location = pin.foodTruck?.location ?? ""
            sel.operationHours = pin.foodTruck?.operationHours ?? ""
            sel.coordinate = pin.coordinate
            //CLLocationCoordinate2D(latitude: Double(pin.foodTruck?.latitude ?? "0")!,longitude: Double(pin.foodTruck?.longitude ?? "0")!)

            self.selectedFoodTruck = sel
         }

         func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
             guard (view.annotation as? PinFoodTrucksLocation) != nil else {
                 return
             }
             selectedFoodTruck = nil
         }
     }
    
    var foodTruckVM: FoodTruckListViewModel!
    var filteredFoodTruck: FoodTruckViewModel!
    @Binding var selectedFoodTruck: SelectFoodTruck?
    @Binding var userLocation: CLLocationCoordinate2D?


    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedFoodTruck: $selectedFoodTruck)
    }
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.showsUserLocation = true

        locationManager.requestAlwaysAuthorization()

        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            
            //if self.userLocation == nil {
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    if let locValue = self.locationManager.location {
                        print("CURRENT LOCATION = \(locValue.coordinate.latitude) \(locValue.coordinate.longitude)")
                        
                        let coordinate = CLLocationCoordinate2D(
                            latitude: locValue.coordinate.latitude, longitude: locValue.coordinate.longitude)
                        
                        self.userLocation = coordinate
                        let span = MKCoordinateSpan(latitudeDelta: 0.095, longitudeDelta: 0.095)
                        let region = MKCoordinateRegion(center: coordinate, span: span)
                        mapView.setRegion(region, animated: true)
                        
                    }
                })
            //}
        } else {
            //Default SF lat and long
            let coordinate = CLLocationCoordinate2D(
                latitude: 37.787359, longitude: -122.408227)
            let span = MKCoordinateSpan(latitudeDelta: 0.095, longitudeDelta: 0.095)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)


        }

        var pins: [PinFoodTrucksLocation] = []

        if filteredFoodTruck != nil {
            let location = self.filteredFoodTruck.coordinates[0]
            pins.append(PinFoodTrucksLocation(foodTruck: filteredFoodTruck, coordinate: location))
            
//            let sel = SelectFoodTruck()
//            sel.applicant = filteredFoodTruck?.applicant ?? ""
//            sel.descr = filteredFoodTruck?.descr ?? ""
//            sel.location = filteredFoodTruck?.location ?? ""
//            sel.operationHours = filteredFoodTruck?.operationHours ?? ""
//            sel.coordinate = filteredFoodTruck.coordinates[0]
//            self.selectedFoodTruck = sel

        } else {
            for foodTruck in self.foodTruckVM.foodTrucks {
                for location in foodTruck.coordinates {
                    pins.append(PinFoodTrucksLocation(foodTruck: foodTruck, coordinate: location))
                }
            }
        }
        mapView.addAnnotations(pins)
        mapView.showAnnotations(pins, animated: true)
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: CLLocationCoordinate2D(latitude: 37.787359, longitude: -122.408227))
//    }
//}
