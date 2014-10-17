//
//  ViewController.swift
//  bouncing labels
//
//  Created by Alexandre Noto on 06/10/2014.
//  Copyright (c) 2014 fitroad.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //create ivar
    
    var myFirstLabel:UILabel!
    var iPhoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myFirstLabel = UILabel()
        iPhoneLabel = UILabel()
        
        addLabels()

        println("\(view.bounds.size)")
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "handleTapGesture:")
        view.addGestureRecognizer(tapGesture)
    }
    
    func handleTapGesture (tapGesture: UITapGestureRecognizer) {
        
        addLabels()
        
    }
    
    func addLabels() {
        myFirstLabel.text = "My First"
        myFirstLabel.font = UIFont.systemFontOfSize(36)
        myFirstLabel.sizeToFit()
        myFirstLabel.center = CGPoint(x: 100, y: 40)
        view.addSubview(myFirstLabel)
        
        iPhoneLabel.text = "iPhone App"
        iPhoneLabel.font = UIFont.boldSystemFontOfSize(48)
        
        iPhoneLabel.sizeToFit()
        iPhoneLabel.alpha = 0
        iPhoneLabel.center = CGPoint(x: 200, y: 150)
        view.addSubview(iPhoneLabel)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            
            self.myFirstLabel.center = CGPoint(x:100 + 50, y:40)
            
            }, completion: nil)
        
        UIView.animateWithDuration(2.0, delay: 0.5, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: nil, animations: {
            self.iPhoneLabel.center = CGPoint(x: 200 + 100, y: 90 )
            self.iPhoneLabel.alpha = 1
            }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

