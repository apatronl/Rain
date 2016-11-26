//
//  InterfaceController.swift
//  Rain Watch Extension
//
//  Created by Alejandrina Patron on 5/17/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation


class InterfaceController: WKInterfaceController, CLLocationManagerDelegate {

    @IBOutlet var locationLabel: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let locationManager = CLLocationManager()
        //        set delegate
        locationManager.delegate = self
        //        Set desiredAccuracy using a GPS of IP:
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //        request to use location
        
        locationManager.requestAlwaysAuthorization()
        //        start update location
        locationManager.requestLocation()

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Watch user's location: \(location)")
            locationLabel.setText("\(location.altitude)")
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
        // Could not determine location
        // SHOW ALERT
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
