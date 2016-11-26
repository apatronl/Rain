//
//  ByeVC.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/26/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit
import SafariServices

class HourlyViewController: UIViewController, SFSafariViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var weather: HourlyWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weather = weather {
            return weather.data.count >= 24 ? 24 : weather.data.count // Show forecast for next 24 hours, if available
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyForecastCell", for: indexPath as IndexPath) as! HourlyForecastCell
        if let weather = weather {
            cell.data = weather.data[indexPath.row]
        }
        return cell
    }
    
    @IBAction func poweredButtonPressed(_ sender: UIButton) {
        let sfc = SFSafariViewController(url: NSURL(string: "http://www.darksky.net")! as URL)
        sfc.delegate = self
        sfc.view.tintColor = UIColor.black
        self.present(sfc, animated: true, completion: nil)
    }
    
}
