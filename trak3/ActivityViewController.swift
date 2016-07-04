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
    
    
    
    @IBOutlet weak var map: MKMapView!
    
    
    
    
    
    @IBOutlet weak var unitsLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    
    @IBOutlet weak var speedOutputLabel: UILabel!
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    @IBOutlet weak var distanceOutputLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var timeOutputLabel: UILabel!
    
    
    @IBAction func startActivityButton(sender: AnyObject) {
    }
    
    
    @IBAction func pauseActivityButton(sender: AnyObject) {
    }
    
    
    @IBAction func endActivityButton(sender: AnyObject) {
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
