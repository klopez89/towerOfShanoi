//
//  Block.swift
//  TowerOfShanoi
//
//  Created by Kevin E Lopez on 1/10/15.
//  Copyright (c) 2015 Kevin E Lopez. All rights reserved.
//

import UIKit

class Block: UIView {
    
    weak var image: UIImageView!
    var size: String!
    var column: Int!
    weak var delegate: AnyObject!
    weak var topObject: AnyObject!
    weak var timer: NSTimer!
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.blueColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func firePositionChecker() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "fallingObjectCheck", userInfo: nil, repeats: true)
    }
    
    
    func fallingObjectCheck() {
        
        let viewController = self.delegate as ViewController
        let leftColumn = viewController.leftColumn
        let middleColumn = viewController.middleColumn
        let rightColumn = viewController.rightColumn
        
        if self.column == 1 {
            
            if (leftColumn.arrayOfObjects.count != 0) {
                if self.frame.intersects(leftColumn.topObject.frame) {
                    NSLog("Intersected")
                    timer.invalidate()
                }
            } else {
                
                if self.layer.presentationLayer().frame.origin.y == viewController.view.frame.height - self.frame.height {
                    //  NSLog("Got to the bottom")
                    viewController.assignNewTopObject(self)
                    timer.invalidate()
                }
            }
            
        } else if self.column == 2 {
            
            if (middleColumn.arrayOfObjects.count != 0) {
                if self.frame.intersects(middleColumn.topObject.frame) {
                    NSLog("Intersected")
                    timer.invalidate()
                }
            } else {
                
                if self.layer.presentationLayer().frame.origin.y == viewController.view.frame.height - self.frame.height {
                    //  NSLog("Got to the bottom")
                    viewController.assignNewTopObject(self)
                    timer.invalidate()
                }
            }
            
        } else if self.column == 3 {
            
            if (rightColumn.arrayOfObjects.count != 0) {
                if self.frame.intersects(rightColumn.topObject.frame) {
                    NSLog("Intersected")
                    timer.invalidate()
                }
            } else {
                
                if self.layer.presentationLayer().frame.origin.y == viewController.view.frame.height - self.frame.height {
                    //  NSLog("Got to the bottom")
                    viewController.assignNewTopObject(self)
                    timer.invalidate()
                }
            }
        }

        
        
        
        
        
    }
    
    
    func drop() {
        
        let viewController = self.delegate as ViewController
        UIView.animateWithDuration(3.0, animations: { () -> Void in
            
            self.frame.origin.y = viewController.view.frame.height - self.frame.height
            
        }) { (Bool) -> Void in
            
         //   NSLog("Landed!")
   
        }

    }
    
    

}
