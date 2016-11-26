//
//  Utils.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/24/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

extension UITableViewController {
    func setTableBackground() {
        let background = UIImageView(image: UIImage(named: "rain-background.jpg"))
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)) as UIVisualEffectView
        visualEffectView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height))
        background.addSubview(visualEffectView)
        tableView.backgroundView = background
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension String {
    func getEmoji() -> String {
        switch self {
        case "clear-day":
            return "☀️"
        case "clear-night":
            return "🌙"
        case "rain":
            return "☔️"
        case "snow":
            return "❄️"
        case "sleet":
            return "🌨"
        case "wind":
            return "🌬"
        case "fog":
            return "🌫"
        case "cloudy":
            return "☁️"
        case "partly-cloudy-day":
            return "🌤"
        case "partly-cloudy-night":
            return "🌥"
        default:
            return "❓"
        }
    }
}

extension Double {
    func getTime() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        return dateFormatter.string(from: date as Date)
    }
    
    func getDay() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date as Date)
    }
}
