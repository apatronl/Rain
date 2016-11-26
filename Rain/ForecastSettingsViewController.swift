//
//  ForecastSettingsViewController.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/24/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class ForecastSettingsViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var imperialCell: UITableViewCell!
    @IBOutlet weak var metricCell: UITableViewCell!
    
    override func viewDidLoad() {
        self.setTableBackground()
        setUnitSelection()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            tableView.deselectRow(at: indexPath as IndexPath, animated: false)
            if self.metricCell.accessoryType == UITableViewCellAccessoryType.none {
                self.imperialCell.accessoryType = UITableViewCellAccessoryType.none
                self.metricCell.accessoryType = UITableViewCellAccessoryType.checkmark
                self.defaults.set(1, forKey: Constants.Keys.UnitsKey)
            }
        } else if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath as IndexPath, animated: false)
            if self.imperialCell.accessoryType == UITableViewCellAccessoryType.none {
                self.imperialCell.accessoryType = UITableViewCellAccessoryType.checkmark
                self.metricCell.accessoryType = UITableViewCellAccessoryType.none
                self.defaults.set(0, forKey: Constants.Keys.UnitsKey)
            }
        }
    }

    func setUnitSelection() {
        let unit = defaults.object(forKey: Constants.Keys.UnitsKey) as? Int
        
        if unit == nil {
            self.imperialCell.accessoryType = UITableViewCellAccessoryType.checkmark
            self.metricCell.accessoryType = UITableViewCellAccessoryType.none
            defaults.set(0, forKey: Constants.Keys.UnitsKey)
        } else if unit == 0 {
            self.imperialCell.accessoryType = UITableViewCellAccessoryType.checkmark
            self.metricCell.accessoryType = UITableViewCellAccessoryType.none
        } else {
            self.imperialCell.accessoryType = UITableViewCellAccessoryType.none
            self.metricCell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }
    
}
