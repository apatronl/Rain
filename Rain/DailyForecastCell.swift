//
//  DailyForecastCell.swift
//  Rain
//
//  Created by Alejandrina Patron on 6/7/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class DailyForecastCell: UITableViewCell {
    
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    var data: DailyData! {
        didSet {
            emoji.text = data.emoji
            temperature.text = data.maxTemp! + "/" + data.minTemp!
            day.text = data.day
        }
    }
    
}
