//
//  ViewController.swift
//  smileys
//
//  Created by Prachie Banthia on 11/2/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet var panForCanvas: UIPanGestureRecognizer!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var newlyCreatedFace: UIImageView!
    var smileyOriginalCenter: CGPoint!
    var newSmileyCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        trayCenterWhenOpen = trayView.center
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y + 320)
        
    }

    @IBAction func onSmileyPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: newlyCreatedFace)
        
        if sender.state == .began {
            // Gesture recognizers know the view they are attached to
            let imageView = sender.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            
            // The didTap: method will be defined in Step 3 below.
            let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            
            
            // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panRecognizer)
            
            
            panForCanvas.delegate = self
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            smileyOriginalCenter = newlyCreatedFace.center
        } else if sender.state == UIGestureRecognizerState.changed {
            newlyCreatedFace.center = CGPoint(x: smileyOriginalCenter.x + translation.x, y: smileyOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = sender.location(in: trayView)
        //let translation = sender.translation(in: trayView)
        let velocity = sender.velocity(in: trayView)
        
        
        if sender.state == .began {
            print("Gesture began at: \(point)")
            print(trayView.center)
            trayOriginalCenter = trayView.center
            print("original center\(trayOriginalCenter!)")
        } else if sender.state == UIGestureRecognizerState.changed {
            print("Gesture changed at: \(point)")
            
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3, animations: { 
                     self.trayView.center = self.trayCenterWhenClosed
                })
               
            } else {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.trayView.center = self.trayCenterWhenOpen
                })
                
                
            }
            
            // trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.ended {
            print("Gesture ended at: \(point)")
        }
    }
    
    
    func didPan(sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = sender.location(in: newlyCreatedFace)
        let translation = sender.translation(in: newlyCreatedFace)
        
        
        
            let velocity = sender.velocity(in: newlyCreatedFace)
            
            if sender.state == .began {
                print("Gestyyyyyure began at: \(point)")
                newSmileyCenter = newlyCreatedFace.center
                
            } else if sender.state == UIGestureRecognizerState.changed {
                print("Gesture changed at: \(point)")
                newlyCreatedFace.center = CGPoint(x: newSmileyCenter.x + translation.x, y: newSmileyCenter.y + translation.y)
            } else if sender.state == UIGestureRecognizerState.ended {
                print("Gesture ended at: \(point)")
            }
    }
    /*
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = gestureRecognizer.location(in: newlyCreatedFace)
        //let translation = sender.translation(in: newlyCreatedFace)
        
        var pan: UIPanGestureRecognizer?
        pan = gestureRecognizer as! UIPanGestureRecognizer
        print("in the gesture recognizer")
        
        
        if let gestureRecognizer = pan {
            print("gesture is a pan")
            
            let velocity = gestureRecognizer.velocity(in: newlyCreatedFace)
            
            if gestureRecognizer.state == .began {
                print("Gestyyyyyure began at: \(point)")
                newSmileyCenter = newlyCreatedFace.center
                
            } else if gestureRecognizer.state == UIGestureRecognizerState.changed {
                print("Gesture changed at: \(point)")
                
                if velocity.y > 0 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.trayView.center = self.trayCenterWhenClosed
                    })
                    
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.trayView.center = self.trayCenterWhenOpen
                    })
                    
                    
                }
                
                // trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            } else if gestureRecognizer.state == UIGestureRecognizerState.ended {
                print("Gesture ended at: \(point)")
            }

        }
        
        
        
        return true
    } */
}

