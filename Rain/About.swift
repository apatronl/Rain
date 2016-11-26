//
//  About.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/30/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation

class About: UIViewController {
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dict = Bundle.main.infoDictionary {
            if let version = dict["CFBundleShortVersionString"] as? String,
                let bundleVersion = dict["CFBundleVersion"] as? String,
                let appName = dict["CFBundleName"] as? String {
                self.versionLabel.text = "🚀 \(appName) \(version) (\(bundleVersion))"
                self.versionLabel.isHidden = false
            }
        }
    }
}

class EmojiTable: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableBackground()
    }
}
