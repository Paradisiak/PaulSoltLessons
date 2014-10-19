//
//  MenuViewController.swift
//  Meme
//
//  Created by Alexandre Noto on 19/10/2014.
//  Copyright (c) 2014 paradisiak.com. All rights reserved.
//

import UIKit

import UIKit

class MenuViewController: UIViewController {
    
    var mainVC:ViewController!
    let orangeColor:UIColor = UIColor(red: 1.0, green: 127 / 255, blue: 0.0, alpha: 1.0)
    var libraryButton:UIButton!
    var cameraButton:UIButton!
    var separator:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        libraryButton = UIButton()
        
        libraryButton.setTitle("Library", forState: UIControlState.Normal)
        libraryButton.setTitleColor(orangeColor, forState: UIControlState.Normal)
        libraryButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        libraryButton.sizeToFit()
        libraryButton.addTarget(self, action: "libraryButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(libraryButton)
        
        separator = UIView()
        separator.backgroundColor = orangeColor
        view.addSubview(separator)
        
        cameraButton = UIButton()
        
        cameraButton.setTitle("Camera", forState: UIControlState.Normal)
        cameraButton.setTitleColor(orangeColor, forState: UIControlState.Normal)
        cameraButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 20)
        cameraButton.sizeToFit()
        cameraButton.addTarget(self, action: "cameraButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(cameraButton)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        preferredContentSize = CGSize(width: 200, height: 100)
        libraryButton.center = CGPoint(x: 100, y: 25)
        separator.frame = CGRect(x: 0, y: 50, width: 200, height: 1)
        cameraButton.center = CGPoint(x: 100, y: 75)
    }
    
    func libraryButtonPressed () {
        
        self.dismissViewControllerAnimated(false, completion: {self.mainVC.getImagePicker("library")})
    }
    
    func cameraButtonPressed () {
        
        self.dismissViewControllerAnimated(false, completion: {self.mainVC.getImagePicker("camera")})
    }

}
