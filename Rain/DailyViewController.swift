//
//  DailyViewController.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/26/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit
import SafariServices

class DailyViewController: UIViewController, SFSafariViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var weather: DailyWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        updateUI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weather = weather {
            return weather.data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyForecastCell", for: indexPath as IndexPath) as! DailyForecastCell

        if let weather = weather {
            cell.data = weather.data[indexPath.row]
        }
        return cell
    }

    func updateUI() {
        if let weather = weather {
            self.summaryLabel.text = weather.summary
        }
    }
    
    @IBAction func poweredButtonPressed(_ sender: UIButton) {
        let sfc = SFSafariViewController(url: NSURL(string: "http://www.darksky.net")! as URL)
        sfc.delegate = self
        sfc.view.tintColor = UIColor.black
        self.present(sfc, animated: true, completion: nil)
    }
    
}
