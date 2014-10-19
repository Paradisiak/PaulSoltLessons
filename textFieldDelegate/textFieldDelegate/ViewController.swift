//
//  ViewController.swift
//  textFieldDelegate
//
//  Created by Alexandre Noto on 19/10/2014.
//  Copyright (c) 2014 paradisiak.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var data:String?
    @IBOutlet weak var textField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = self
        
        textField.addTarget(self, action: Selector("textFieldDidChange:"), forControlEvents: UIControlEvents.EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: UIButton) {
        
        saveLogic()
        dismissKeyboard()
    }
    
    func textFieldDidChange(sender: UITextField) {
        
        saveLogic()
    }
    
    
    func saveLogic () {
        
        data = textField.text
        println("data: \(data)")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        saveLogic()
        dismissKeyboard()
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(false)
    }

}

