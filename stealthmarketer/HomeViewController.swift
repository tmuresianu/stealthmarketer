//
//  HomeViewController.swift
//  stealthmarketer
//
//  Created by Toby Muresianu on 5/2/15.
//  Copyright (c) 2015 tobymuresianu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate {
    
    //var imagePickerController:UIImagePickerController
    
    @IBAction func openCamera() {
        println("openCamera called")
    }
    
    @IBAction func openLibrary() {
        println("openLibrary called")
        
        
    //    self.imagePickerController = UIImagePickerController()
      /*  self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum
        self.presentViewController(self.imagePickerController)
    */
}
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        
    }

}
