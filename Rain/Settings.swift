//
//  Settings.swift
//  Rain
//
//  Created by Alejandrina Patron on 11/25/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//


struct Settings {
    
    private static let defaults = UserDefaults.standard
    
    static func getUnits() -> String {
        let units = defaults.object(forKey: Constants.Keys.UnitsKey) as? Int
        return ((units == nil || units == 0) ? "us" : "si")
    }
    
}
