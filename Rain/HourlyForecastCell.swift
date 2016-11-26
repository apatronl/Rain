//
//  HourlyForecastCell.swift
//  Rain
//
//  Created by Alejandrina Patron on 6/7/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class HourlyForecastCell: UITableViewCell {
    
    @IBOutlet weak var emoji: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    var data: HourlyData! {
        didSet {
            time.text = data.time
            temperature.text = data.temperature
            emoji.text = data.emoji
        }
    }
    
}
