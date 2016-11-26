//
//  NotificationSettingsViewController.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/26/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class NotificationSettingsViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dayBeforeCell: UITableViewCell!
    @IBOutlet weak var dayOfCell: UITableViewCell!
    
    override func viewDidLoad() {
        self.setTableBackground()
        setDaySelection()
        datePicker.setValue(UIColor.white, forKey: "textColor")
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 1 {
            tableView.deselectRow(at: indexPath as IndexPath, animated: false)
            if self.dayOfCell.accessoryType == UITableViewCellAccessoryType.none {
                self.dayBeforeCell.accessoryType = UITableViewCellAccessoryType.none
                self.dayOfCell.accessoryType = UITableViewCellAccessoryType.checkmark
                self.defaults.set(1, forKey: Constants.Keys.RemindMeKey)
            }
        } else if indexPath.section == 1 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath as IndexPath, animated: false)
            if self.dayBeforeCell.accessoryType == UITableViewCellAccessoryType.none {
                self.dayBeforeCell.accessoryType = UITableViewCellAccessoryType.checkmark
                self.dayOfCell.accessoryType = UITableViewCellAccessoryType.none
                self.defaults.set(0, forKey: Constants.Keys.RemindMeKey)
            }
        }
    }
    
    
    func setDaySelection() {
        let unit = defaults.object(forKey: Constants.Keys.RemindMeKey) as? Int
        
        if unit == nil {
            self.dayOfCell.accessoryType = UITableViewCellAccessoryType.checkmark
            self.dayBeforeCell.accessoryType = UITableViewCellAccessoryType.none
            defaults.set(1, forKey: Constants.Keys.RemindMeKey)
        } else if unit == 0 {
            self.dayBeforeCell.accessoryType = UITableViewCellAccessoryType.checkmark
            self.dayOfCell.accessoryType = UITableViewCellAccessoryType.none
        } else {
            self.dayBeforeCell.accessoryType = UITableViewCellAccessoryType.none
            self.dayOfCell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }
}
