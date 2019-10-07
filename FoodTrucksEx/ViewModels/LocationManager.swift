//
//  LocationManager.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 9/3/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import Combine
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager: CLLocationManager
    var didChange = PassthroughSubject<LocationManager, Never>()

    var lastKnownLocation: CLLocation? {
        didSet {
            didChange.send(self)
        }
    }

    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
    }

    func startUpdating() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        lastKnownLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
}
