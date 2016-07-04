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
    
    func increaseTimer(){
        
        time = time + 1
        
        if time > 3600 {
            
            let hours = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            
            //            let secondsQuantity = HKQuantity(unit: HKUnit.secondUnit(), doubleValue: time)
            //            let distanceQuantity = HKQuantity(unit: HKUnit.meterUnit(), doubleValue: distance)
            
            timeOutputLabel.text = String(format:"%02i:%02i:%02i", hours, minutes, seconds)
           
            
        } else {
            
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            
            timeOutputLabel.text = String(format:"%02i:%02i", minutes, seconds)
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func startActivityButton(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ActivityViewController.increaseTimer), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func pauseActivityButton(sender: AnyObject) {
        
        timer.invalidate()
        
    }
    
    
    @IBAction func endActivityButton(sender: AnyObject) {
        
        timer.invalidate()
        time = 0
        timeOutputLabel.text = "00:00"
        
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
        
        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        print(locations)
        
        
        
        for location in locations {
                
                if locations.count > 0 {
                    
                    print(locations)
                    distance = distance + location.distanceFromLocation(locations[0])
                    print(distance)

                    if units == "Metric" {
                        
                        var speed = location.speed
                        var speedKph = String(format: "%.2f", speed * 3.6)
                        
                        self.speedOutputLabel.text = "\(speedKph)"
                        
                    } else {}

                    
                } else {
                    
                    self.locations.append(locations[0])
                    
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
