//
//  DarkSkyService.swift
//  Rain
//
//  Created by Alejandrina Patron on 8/18/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Alamofire

public struct DarkSkyService {
    
    private static let baseUrl = "https://api.darksky.net/forecast/"
    private static let apiKey = "00ded97466876acd8521b9c327bccea0"
    
    /// Makes request to the Dark Sky API
    ///
    /// - Parameters:
    ///     - latitude: location's latitude coordinate
    ///     - longitude: location's longitude coordinate
    ///     - completion: handler to execute when network request is complete
    static func weatherForCoordinates(latitude: String, longitude: String, completion: @escaping (WeatherData?, Error?) -> ()) {
        let url = baseUrl + "\(apiKey)/\(latitude),\(longitude)"
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                let weather = WeatherData(data: response.result.value!)
                completion(weather, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // In this struct you could have more funcs. For example,
    // weatherForZipCode(...), weatherForCity(...) depending on the parameter(s) you pass
}
