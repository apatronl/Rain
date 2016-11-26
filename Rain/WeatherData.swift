//
//  WeatherData.swift
//  Rain
//
//  Created by Alejandrina Patron on 11/25/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import SwiftyJSON

// MARK: Main weather

struct WeatherData {
    
    var city: String?
    var temperature: String?
    var emoji: String?
    var today: TodayWeather?
    var hourly: HourlyWeather?
    var daily: DailyWeather?
    
    init(data: Any) {
        // Main
        let json = JSON(data)
        let currentWeather = json["currently"]
        if let temp = currentWeather["temperature"].float {
            temperature = String(format: "%.0f", temp) + "º" // + (units == "si" ? "C" : "F")
        } else {
            temperature = "--"
        }
        emoji = currentWeather["icon"].string!.getEmoji()
        
        // Pages
        today = TodayWeather(currentWeather: currentWeather)
        hourly = HourlyWeather(hourlyWeather: json["hourly"])
        daily = DailyWeather(dailyWeather: json["daily"])
        
        
    }
    
}

//let hourlyData = todayData["hourly"]
//if (hourlyData["icon"] == "rain") {
//    answer = "Yes"
//    return answer
//}

// MARK: Today's weather

struct TodayWeather {
    
    var answer: String?
    var summary: String?
    
    init(currentWeather: JSON) {
        self.answer = "No"
        let currData = currentWeather["precipProbability"].float!
        if currData > 0 {
            self.answer = "Yes"
        }

        self.summary = currentWeather["summary"].string ?? "--"
    }
    
}

// MARK: Hourly weather

struct HourlyWeather {
    
    var data = [HourlyData]()
    
    init(hourlyWeather: JSON) {
        if let hourlyData = hourlyWeather["data"].array {
            for i in 0...hourlyData.count - 1 {
                data.append(HourlyData(data: hourlyData[i]))
            }
        }
    }
}

struct HourlyData {
    
    var emoji: String?
    var temperature: String?
    var time: String?
    
    init(data: JSON) {
        emoji = (data["icon"].string ?? "--").getEmoji()
        if let temperature = data["temperature"].float {
            self.temperature = String(format: "%.0f", temperature) + "º"
        } else {
            self.temperature = "--"
        }
        if let time = data["time"].double {
            self.time = time.getTime()
        } else {
            self.time = "--"
        }
    }
}

// MARK: Daily weather

struct DailyWeather {
    
    var data = [DailyData]()
    var summary: String?
    
    init(dailyWeather: JSON) {
        if let dailyData = dailyWeather["data"].array {
            for i in 0...dailyData.count - 1 {
                data.append(DailyData(data: dailyData[i]))
            }
        }
        summary = dailyWeather["summary"].string ?? "--"
    }
}

struct DailyData {
    
    var minTemp: String?
    var maxTemp: String?
    var emoji: String?
    var day: String?
    
    init(data: JSON) {
        if let min = data["temperatureMin"].float {
            minTemp = String(format: "%.0f", min)
        } else {
            minTemp = "--"
        }
        if let max = data["temperatureMax"].float {
            maxTemp = String(format: "%.0f", max)
        } else {
            maxTemp = "--"
        }
        if let day = data["time"].double {
            self.day = day.getDay()
        } else {
            self.day = "--"
        }
        emoji = (data["icon"].string ?? "--").getEmoji()
    }
}
