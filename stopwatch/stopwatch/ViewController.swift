//
//  ViewController.swift
//  stopwatch
//
//  Created by Alexandre Noto on 17/10/2014.
//  Copyright (c) 2014 paradisiak.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    var timer:NSTimer?
    var startTime:NSDate?
    var currentTime:NSDate?
    var stopTime:NSDate?
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButtonPressed(sender: UIButton) {
        
        startTime = NSDate()
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTimer:"), userInfo: nil, repeats: true)
        }
        
    }

    func updateTimer(timer:NSTimer) {
        currentTime = NSDate()

        var duration = currentTime?.timeIntervalSinceDate(startTime!)
        var dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "HH:mm:ss.SS"
        timeLabel.text = dateFormater.stringFromDate(duration)
        

    }
    
    @IBAction func stropButtonPressed(sender: UIButton) {
        
        stopTime = NSDate()
        timer?.invalidate()
        
    }
    
    @IBAction func resetButtonPressed(sender: UIButton) {
        
        
    }
    
    
    
}

