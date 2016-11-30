//
//  HelloVC.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/26/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit
import SafariServices
class TodayViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var weather: TodayWeather?
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func poweredButtonPressed(_ sender: UIButton) {
        let sfc = SFSafariViewController(url: NSURL(string: "http://www.darksky.net")! as URL)
        sfc.delegate = self
        sfc.view.tintColor = UIColor.black
        self.present(sfc, animated: true, completion: nil)
    }
    
    func updateUI() {
        if let weather = weather {
            self.answerLabel.text = weather.answer
            self.summary.text = weather.summary
        }
    }
}
