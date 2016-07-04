//
//  ActivityViewController.swift
//  trak3
//
//  Created by George Gogarten on 7/4/16.
//  Copyright © 2016 George Gogarten. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import HealthKit

class ActivityViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    var timer = NSTimer()
    
    var time = 0.0
    
    var distance = 0.0
    
    var units = String("Metric")
    
    var pausedState = false
    
    var activityLive = false
    
    var locations = [CLLocation]()
    
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var unitsLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    
    @IBOutlet weak var speedOutputLabel: UILabel!
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    @IBOutlet weak var distanceOutputLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var timeOutputLabel: UILabel!
    
    
    @IBOutlet weak var startActivityButtonLabel: UIButton!
    
    
    @IBOutlet weak var unitSwitch: UISwitch!
    
    
    
    @IBAction func unitSwitchTrigger(sender: AnyObject) {
        
        if unitSwitch.on == true {
            
            print("Switch On")
            units = "Metric"
            unitsLabel.text = String("Metric")
            speedLabel.text = String("Speed (Kph)")
            
            
        } else {
            
            print("Switch Off")
            units = "Imperial"
            unitsLabel.text = String("Imperial")
            speedLabel.text = String("Speed (Mph)")
        }
    }
    
    
    
    
    func increaseTimerandDistance(){
        
        unitsLabel.text = units
        
        time = time + 1
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let meters = self.distance
        let yards = meters * 1.09361
        let miles = meters * 0.000621371
        let kilometers = meters / 1000
        
        
        if time > 3600 {
            
            timeOutputLabel.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
            
        } else {
            
            timeOutputLabel.text = String(format:"%02i:%02i", minutes, seconds)
            
        }
        
        if units == "Metric" {
            
            if meters > 1000 {
                
                distanceOutputLabel.text = String(format:"%00.2f", kilometers)
                distanceLabel.text = String("Distance (Km)")
                
            } else {
                
                distanceOutputLabel.text = String(format:"%3.f", meters)
                distanceLabel.text = String("Distance (Meters)")
                
            }
            
        } else {
            
            if yards > 1000 {
                
                distanceOutputLabel.text = String(format:"%00.2f", miles)
                distanceLabel.text = String("Distance (Miles)")
                
            } else {
                
                distanceOutputLabel.text = String(format:"%3.f", yards)
                distanceLabel.text = String("Distance (Yards)")
                
            }
        }
    }
    
    
    
    
    @IBAction func startActivityButton(sender: AnyObject) {
        
        if pausedState == true {
            
            locationManager.startUpdatingLocation()
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ActivityViewController.increaseTimerandDistance), userInfo: nil, repeats: true)
            
            activityLive = true
            
        } else {
            
            if activityLive == true {
                
                locationManager.startUpdatingLocation()
                
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ActivityViewController.increaseTimerandDistance), userInfo: nil, repeats: true)
                
                
            } else {
                
                self.distance = 0.0
                
                locationManager.startUpdatingLocation()
                
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ActivityViewController.increaseTimerandDistance), userInfo: nil, repeats: true)
                
                activityLive = true
                
            }
            
        }
        
    }
    
    
    @IBAction func pauseActivityButton(sender: AnyObject) {
        
        timer.invalidate()
        
        pausedState = true
        
        startActivityButtonLabel.setTitle("Go", forState: UIControlState.Normal)
        
        locationManager.stopUpdatingLocation()
        
    }
    
    
    @IBAction func endActivityButton(sender: AnyObject) {
        
        timer.invalidate()
        time = 0
        timeOutputLabel.text = "00:00"
        distanceOutputLabel.text = "0"
        pausedState = false
        activityLive == false
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .Fitness
        locationManager.distanceFilter = 5.0
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
        self.map.showsUserLocation = true
        self.map.mapType = MKMapType(rawValue: 0)!
        self.map.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        
        unitSwitchTrigger(true)
        
        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        
        if oldLocation != nil {
            
            distance = distance + newLocation.distanceFromLocation(oldLocation)
            
            print(distance)
            
            if units == "Metric" {
                
                var speed = newLocation.speed
                var speedKph = String(format: "%.2f", speed * 3.6)
                
                self.speedOutputLabel.text = "\(speedKph)"
                
            } else {
                
                var speed = newLocation.speed
                var speedMph = String(format: "%.2f", speed * 2.2369363)
                
                self.speedOutputLabel.text = "\(speedMph)"
                
                
                
            }
        }
    }
    
    
    //        print("present location : \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
    //        print("speed : \(newLocation.speed)")
    
    
    
    
    
    
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
