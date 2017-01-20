//
//  Settings.swift
//  Rain
//
//  Created by Alejandrina Patron on 11/25/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//


struct Settings {
    
    private static let defaults = UserDefaults.standard
    
    // If the value saves is 0 or nil, temperature will be reported in Farenheit
    // If the value saved is 1, temperature will be reported in Celsius
    static func getTemperatureUnits() -> String {
        let units = defaults.object(forKey: Constants.Keys.UnitsKey) as? Int
        return ((units == nil || units == 0) ? "us" : "si")
    }
    
}
