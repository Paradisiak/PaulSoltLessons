//
//  ViewController.swift
//  imageDemo
//
//  Created by Alexandre Noto on 19/10/2014.
//  Copyright (c) 2014 paradisiak.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func imageButtonPressed(sender: UIButton) {
        
        
        var imagePicker = UIImagePickerController()
        var sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        //camera for real device
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
            
        presentViewController(imagePicker, animated: true, completion: nil)
            
            
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        println("cancel")
        dismissViewControllerAnimated(true, completion: nil)
    }
}

