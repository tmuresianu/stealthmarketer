//
//  DraggableImageView.swift
//  stealthmarketer
//
//  Created by Toby Muresianu on 5/5/15.
//  Copyright (c) 2015 tobymuresianu. All rights reserved.
//

import UIKit

class DraggableImageView : UIImageView {
    
    var lastLocation:CGPoint = CGPointMake(0, 0)
    
    var rotationRecognizer:UIRotationGestureRecognizer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        self.userInteractionEnabled = true
        var panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
        rotationRecognizer = UIRotationGestureRecognizer(target:self, action:"detectRotation:")
        var pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "detectPinch:")
        self.addGestureRecognizer(rotationRecognizer)
        self.addGestureRecognizer(panRecognizer)
        self.addGestureRecognizer(pinchRecognizer)
       // self.gestureRecognizers = [panRecognizer, rotationRecognizer]
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func detectPinch(recognizer:UIPinchGestureRecognizer){
        self.transform = CGAffineTransformScale(self.transform, recognizer.scale, recognizer.scale)
        recognizer.scale = 1
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
    }
    

    func detectRotation(recognizer:UIRotationGestureRecognizer){
        
        println("rotate called")
        self.transform = CGAffineTransformRotate(self.transform, rotationRecognizer!.rotation);
        
        rotationRecognizer!.rotation = 0.0;
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
    }
}