//
//  NavViewController.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/24/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation

import UIKit

class NavViewController: UINavigationController {
    
    override func viewDidLoad() {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        
        let attrs = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-UltraLight", size: 33)!
        ]
    
        UINavigationBar.appearance().titleTextAttributes = attrs
        self.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(5), for: UIBarMetrics.default)
        
        self.navigationBar.tintColor = UIColor.white
        
        let customFont = UIFont(name: "HelveticaNeue-UltraLight", size: 19.0)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont!], for: UIControlState.normal)
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

