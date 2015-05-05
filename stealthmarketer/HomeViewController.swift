//
//  HomeViewController.swift
//  stealthmarketer
//
//  Created by Toby Muresianu on 5/2/15.
//  Copyright (c) 2015 tobymuresianu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    //var image:UIImage?
    
    @IBOutlet weak var nextbutton:UIButton?
    @IBOutlet weak var imageView:UIImageView?
    
    @IBAction func openCamera() {
        
        println("openCamera called")
        imagePickerController.sourceType = .Camera
        presentViewController(imagePickerController, animated: true, completion: nil);
    
    }
    
    @IBAction func openLibrary() {
    
        println("openLibrary called")
        imagePickerController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        presentViewController(imagePickerController, animated: true, completion: nil);

    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        imagePickerController.delegate = self
        self.title = "Stealth Marketer"
        nextbutton?.hidden = true
        
        self.navigationController?.navigationBarHidden = true
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style:UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        println("didFinishPickingMediaithInfo")
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //self.imageView!.contentMode = .ScaleAspectFit
            //image = pickedImage
            self.imageView!.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
        nextbutton?.hidden = false
        
        //self.performSegueWithIdentifier("ShowPhotoEditingViewController", sender: self);
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        println("prepareForSegue called with Segue: " + segue.identifier!)
        
        if (segue.identifier == "ShowPhotoEditingViewController"){
         
            println("TODO: Pass the image")
            let nextVC:PhotoEditingViewController = segue.destinationViewController as! PhotoEditingViewController
            nextVC.image = self.imageView?.image
        
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
        println("imagePickerControllerDidCancel")
    }
}
