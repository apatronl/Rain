//
//  PagesViewController.swift
//  Rain
//
//  Created by Alejandrina Patron on 5/26/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit
import CoreLocation

class PagesViewController: UIViewController, CLLocationManagerDelegate {
    
    var pageMenu: CAPSPageMenu?
    var todayController: TodayViewController!
    var hourlyController: HourlyViewController!
    var dailyController: DailyViewController!
    let hud = MBProgressHUD()
    
    var location: CLLocation!
    var weather: WeatherData?
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var emoji: UILabel!
    
    override func viewDidLoad() {
        
        // Set up views for page menu
        var controllerArray : [UIViewController] = []
        
        // Today VC
        todayController = UIStoryboard(name: "MenuViewController", bundle: nil).instantiateViewController(withIdentifier: "TodayVC") as! TodayViewController
        todayController.title = "Today"
        controllerArray.append(todayController)
        
        // Hourly VC
        hourlyController = UIStoryboard(name: "MenuViewController", bundle: nil).instantiateViewController(withIdentifier: "HourlyVC") as! HourlyViewController
        hourlyController.title = "Hourly"
        controllerArray.append(hourlyController)
        
        // Daily VC
        dailyController = UIStoryboard(name: "MenuViewController", bundle: nil).instantiateViewController(withIdentifier: "DailyVC") as! DailyViewController
        dailyController.title = "Daily"
        controllerArray.append(dailyController)
        
//        let topMargin: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height+self.navigationController!.navigationBar.frame.size.height;

        // Status height is 20 now, check if it changes
        let topMargin: CGFloat = 20 + self.navigationController!.navigationBar.frame.size.height
        
        // Customize pages menu
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.clear),
            .viewBackgroundColor(UIColor.clear),
            .selectionIndicatorColor(UIColor(red: 253.0/255.0, green: 184.0/255.0, blue:19.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor.clear),
            .menuItemFont(UIFont(name: "HelveticaNeue-Light", size: 13.0)!),
            .menuHeight(40.0),
            .menuItemWidth(self.view.frame.width / 3.5),
            .centerMenuItems(true)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(origin: CGPoint(x: 0,y: topMargin), size: CGSize(width: self.view.frame.width, height: self.view.frame.height - topMargin)), pageMenuOptions: parameters)
        
        
        
        // Add page menu as subview of base view controller view
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
        
        // Set up activity indicator
        hud.labelText = "Loading..."
        hud.labelFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        hud.dimBackground = true
        hud.sendSubview(toBack: pageMenu!.view)
        self.view.addSubview(hud)
        
        // Get location
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        hud.show(true)

    }
    
    // MARK: - Location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
            self.getForecast()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        // SHOW ALERT HERE
        hud.hide(true)
    }
    
    func reverseGeocoding(location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if let _ = error {
                self.hud.hide(true)
                self.weather?.city = "--"
            } else if (placemarks?.count)! > 0 {
                let pm = placemarks![0]
                if let locality = pm.locality {
                    self.weather?.city = locality
                }
            } else {
                self.weather?.city = "--"
            }
            self.cityName.text = self.weather?.city
        })
    }
    
    // MARK: - Forecast and UI updates
    
    func getForecast() {
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        // let units = Settings.getUnits()
        
        DarkSkyService.weatherForCoordinates(latitude: latitude, longitude: longitude) { weatherData, error in
            if let _ = error {
                // SHOW ALERT HERE
                print("Error")
            } else {
                self.weather = weatherData
                self.reverseGeocoding(location: self.location)
                self.todayController.weather = weatherData?.today
                self.hourlyController.weather = weatherData?.hourly
                self.dailyController.weather = weatherData?.daily
                
                self.updateForecastUI()
            }
            self.hud.hide(true)
        }
        
    }
    
    func updateForecastUI() {
        // Update data common in all pages
        temperature.text = weather?.temperature
        emoji.text = weather?.emoji
        
        // Update "Today" page
        todayController.updateUI()
    }

    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        hud.show(true)
        locationManager.requestLocation()
    }
}

// UGLY code

//        Alamofire.request(.GET, url + apiKey + "\(latitude),\(longitude)?units=" + units + "&exclude=minutely").validate().responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    let res = JSON(value)
//                    let temperature = String(format: "%.0f", res["currently"]["temperature"].float!) + "º" + (units == "si" ? "C" : "F")
//                    let emoji = (res["currently"]["icon"].string!).getEmoji()
//                    self.forecast.temperature = temperature
//                    self.forecast.emoji = emoji
//
//                    self.forecast.data = res
//                    self.forecast.today.data = res
//                    self.todayController.forecast = self.forecast.today
//
//                    self.forecast.hourly.data = res
//                    self.hourlyController.forecast = self.forecast.hourly
//
//                    self.forecast.daily.data = res["daily"]
//                    self.dailyController.forecast = self.forecast.daily
//
//                }
//                self.hud.hide(true)
//                self.updateForecastUI()
//                if (self.hourlyController.isViewLoaded()) {
//                    self.hourlyController.tableView.reloadData()
//                }
//                if (self.dailyController.isViewLoaded()) {
//                    self.dailyController.tableView.reloadData()
//                    self.dailyController.updateUI()
//                }
//            case .Failure(let error):
//                print(error)
//                self.hud.hide(true)
//                // Could not connect to the internet
//                print("No internet connection!!!")
//            }
//        }
