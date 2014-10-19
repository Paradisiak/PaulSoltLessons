//
//  ViewController.swift
//  Meme
//
//  Created by Alexandre Noto on 19/10/2014.
//  Copyright (c) 2014 paradisiak.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Gesture
    var dragStartPositionRelativeToCenter:CGPoint = CGPointZero
    var animator: UIDynamicAnimator?
    
    var actualImageView:UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "textureliege"))
        animator = UIDynamicAnimator(referenceView: view);
        let longPress = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        view.addGestureRecognizer(longPress)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLongPress(nizer:UILongPressGestureRecognizer) {
        
        if nizer.state == UIGestureRecognizerState.Began {
            let location = nizer.locationInView(view)

            if view.hitTest(location, withEvent: nil) === self.view {
            
                let photo = UIImageView(frame: CGRect(x: location.x - 75, y: location.y - 75, width: 150, height: 150))
                photo.backgroundColor = UIColor.whiteColor()
                applyPlainShadow(photo)
                photo.contentMode = UIViewContentMode.ScaleAspectFill
                createPanGestureRecognizer(photo)
                createRotateGestureRecognizer(photo)
                createPinchGestureRecognizer(photo)
                createTapGestureRecognizer(photo)
                
                photo.userInteractionEnabled = true
                view.addSubview(photo)
            }
        }
        
        
    }
    
    
    func createTapGestureRecognizer(targetView:UIView) {
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        tap.numberOfTapsRequired = 1
        targetView.addGestureRecognizer(tap)
    }
    
    func handleTap(nizer: UITapGestureRecognizer!) {
        
        let sender = nizer.view! as UIImageView
        let location = nizer.locationInView(sender)
        let menuViewController =  MenuViewController()
        menuViewController.modalPresentationStyle = .Popover
        menuViewController.preferredContentSize = CGSizeMake(50, 100)
        menuViewController.mainVC = self
        actualImageView = sender
        
        let popoverMenuViewController = menuViewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Up
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = sender
        popoverMenuViewController?.sourceRect = CGRect(x: location.x, y: location.y, width: 1, height: 1)
        presentViewController(menuViewController, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle{
        return .None
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        actualImageView = nil
    }
    
    func createPinchGestureRecognizer(targetView:UIImageView) {
        
        let pinch = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
        targetView.addGestureRecognizer(pinch)
    }
    
    func handlePinch(nizer:UIPinchGestureRecognizer) {
        
        nizer.view!.transform = CGAffineTransformScale(nizer.view!.transform,
            nizer.scale, nizer.scale)
        nizer.scale = 1
    }
    
    func createRotateGestureRecognizer(targetView:UIImageView) {
        
        let rotate = UIRotationGestureRecognizer(target: self, action: "handleRotate:")
        targetView.addGestureRecognizer(rotate)

    }
    
    func handleRotate(nizer:UIRotationGestureRecognizer) {
    
        nizer.view!.transform = CGAffineTransformRotate(nizer.view!.transform, nizer.rotation)
        nizer.rotation = 0
    }
    
    
    func createPanGestureRecognizer(targetView: UIImageView) {
        let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
        targetView.addGestureRecognizer(pan)
    }
    
    func handlePan(nizer: UIPanGestureRecognizer!) {
        
        let thePhoto:UIImageView = nizer.view! as UIImageView
        var translation = nizer.translationInView(self.view)
        
        
        if nizer.state == UIGestureRecognizerState.Began {
            animator?.removeAllBehaviors()
            
            
            self.view.bringSubviewToFront(thePhoto)
            let locationInView = nizer.locationInView(self.view)
            
            dragStartPositionRelativeToCenter = CGPoint(x: locationInView.x - thePhoto.center.x, y: locationInView.y - thePhoto.center.y)
            
            applyHoverShadow(thePhoto)
            
            return
        }
        
        if nizer.state == UIGestureRecognizerState.Ended {
            animator?.removeAllBehaviors()
            dragStartPositionRelativeToCenter = CGPointZero
            nizer.setTranslation(CGPointZero, inView: self.view)
            applyPlainShadow(thePhoto)
            
            return
        }
        
        var locationInView = nizer.locationInView(self.view)
        
        UIView.animateWithDuration(0.1) {
            thePhoto.center = CGPoint(
                x: locationInView.x - self.dragStartPositionRelativeToCenter.x,
                y: locationInView.y - self.dragStartPositionRelativeToCenter.y)
        }
    }
    

    
    func getImagePicker (type: String) {
        
        
        var imagePicker = UIImagePickerController()
        var sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        if type == "camera" {
           println("camera")
        sourceType = UIImagePickerControllerSourceType.Camera
        
        }
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            imagePicker.sourceType = sourceType
            
            imagePicker.delegate = self
            
            // show a screen
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        
        if let imageView = actualImageView {
            imageView.image = image
            actualImageView = nil
        }
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        actualImageView = nil
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    


}

func applyPlainShadow(label:UIImageView) {
    var layer = label.layer
    
    label.layer.shadowOffset = CGSize(width: 3, height: 3)
    label.layer.shadowOpacity = 0.7
    label.layer.shadowRadius = 2
    
}

func applyHoverShadow(label:UIImageView) {
    
    var layer = label.layer
    label.layer.shadowOffset = CGSize(width: 10, height: 20)
    label.layer.shadowOpacity = 0.3
    label.layer.shadowRadius = 6
}

