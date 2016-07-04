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

class ActivityViewController: UIViewController {
    
    
   var timer = NSTimer()
    
    var time = 0
    
    
    
    
    @IBOutlet weak var map: MKMapView!
    
    
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

        // Do any additional setup after loading the view.
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
