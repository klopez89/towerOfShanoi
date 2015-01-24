//
//  ViewController.swift
//  TowerOfShanoi
//
//  Created by Kevin E Lopez on 12/21/14.
//  Copyright (c) 2014 Kevin E Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftColumn: Column!
    @IBOutlet weak var middleColumn: Column!
    @IBOutlet weak var rightColumn: Column!
    var columns = [Column]()

    var largeFrame = CGRect()
    var mediumFrame = CGRect()
    var smallFrame = CGRect()
    
    var leftCenter: CGFloat!
    var middleCenter: CGFloat!
    var rightCenter: CGFloat!
    
    var leftMidLine: CGFloat!
    var middleMidLine: CGFloat!
    var rightMidLine: CGFloat!
    
    var size = [String]()
    let smallSize = "small"
    let mediumSize = "medium"
    let largeSize = "large"
    
    var nextBlock: Block!
    var columnStart: Int!
    var columnEnd: Int!
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        size.append(self.smallSize)
        size.append(self.mediumSize)
        size.append(self.largeSize)
        
        columns.append(self.leftColumn)
        columns.append(self.middleColumn)
        columns.append(self.rightColumn)
    }


    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupBlocks()
        addLargeBlock()
        
        NSLog("Dimensions: \(leftColumn.frame.size.width) x \(leftColumn.frame.size.height)")
        
    }
    
    
    
    
    
    
    func setupBlocks() {

    leftMidLine = leftColumn.center.x
    middleMidLine = middleColumn.center.x
    rightMidLine = rightColumn.center.x
    
    largeFrame = CGRectMake(0, leftColumn.frame.origin.y, leftColumn.frame.width, leftColumn.frame.height / 7)
    mediumFrame = CGRectMake(0, middleColumn.frame.origin.y, middleColumn.frame.width / 2 , middleColumn.frame.height / 7)
    smallFrame = CGRectMake(0, rightColumn.frame.origin.y, rightColumn.frame.height / 7, rightColumn.frame.height / 7)

    }
    
    
    
    
    func addLargeBlock() {
        
    let largeBox = createLargeBlock()
        
    //position
    largeBox.center.x = leftMidLine
    largeBox.frame.origin.y = 0 - (3/4) * largeBox.frame.size.height

    
    leftColumn.fallingObject = largeBox
    self.view.addSubview(largeBox)
    largeBox.drop()
    largeBox.firePositionChecker()
    
        
    }
    

    
    
    func createLargeBlock() -> Block {
        
    var largeBlock = Block(frame: largeFrame)
    largeBlock.delegate = self
    largeBlock.topObject = nil
    largeBlock.size = "large"
    largeBlock.column = 1
      
    return largeBlock
    }
    
    
    
    func assignNewTopObject(newObject: Block) {
        
        let columnNumber = newObject.column
    
        if columnNumber == 1 {
            leftColumn.topObject = newObject
            leftColumn.arrayOfObjects.append(newObject)
         //   NSLog("Length of array: \(leftColumn.arrayOfObjects.count)")
        } else if columnNumber == 2 {
            middleColumn.topObject = newObject
            middleColumn.arrayOfObjects.append(newObject)
        }
        
        
        
        
        chooseNextBlock()

    }
    
    
    
    
    func chooseNextBlock() {
        
        let randomColumn = (Int)(arc4random_uniform(3)+1)
        let randomSize = (Int)(arc4random_uniform(3)+0)
        let nextSize = size[randomSize]
        
      //  NSLog("Random column: \(randomColumn) and random Size: \(randomSize)")
        
        if randomSize == 0 {
            nextBlock = Block(frame: largeFrame)
            nextBlock.delegate = self
            nextBlock.column = randomColumn
            setupBlock(nextBlock)
        } else if randomSize == 1 {
            nextBlock = Block(frame: mediumFrame)
            nextBlock.delegate = self
            nextBlock.column = randomColumn
            setupBlock(nextBlock)
        } else if randomSize == 2 {
            nextBlock = Block(frame: smallFrame)
            nextBlock.delegate = self
            nextBlock.column = randomColumn
            setupBlock(nextBlock)
        }
        
        
    }
    
    
    func setupBlock(block: Block) {
        
        if block.column == 1 {
            block.center.x = leftMidLine
        } else if block.column == 2 {
            block.center.x = middleMidLine
        } else if block.column == 3 {
            block.center.x = rightMidLine
        }
        
        block.frame.origin.y = 0 - (3/4) * block.frame.size.height
        
        self.view.addSubview(block)
        block.drop()
        block.firePositionChecker()
    }
    
    

    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        var touch: AnyObject? = touches.anyObject()
        var point = touch?.locationInView(self.view)
       
        if CGRectContainsPoint(leftColumn.frame, point!) {
            columnStart = 0
        } else if CGRectContainsPoint(middleColumn.frame, point!) {
            columnStart = 1
        } else if CGRectContainsPoint(rightColumn.frame, point!) {
            columnStart = 2
        }
        
    }
    
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch: AnyObject? = touches.anyObject()
        var point = touch?.locationInView(self.view)
        
        if CGRectContainsPoint(leftColumn.frame, point!) {
            
            if columnStart == 1 {
                NSLog("Move block from middle to left column")
            }
        } else if CGRectContainsPoint(middleColumn.frame, point!) {
            
            if columnStart == 0 {
                NSLog("Move block from left to middle column")
                
                if leftColumn.arrayOfObjects.count > 0 {
                    leftColumn.arrayOfObjects.removeAtIndex(0) }
                
                middleColumn.topObject = leftColumn.topObject
                leftColumn.topObject = nil
                
                
                
                if middleColumn.arrayOfObjects.count == 0 {
                    middleColumn.topObject.center.x = middleMidLine
                    middleColumn.arrayOfObjects.insert(middleColumn.topObject, atIndex: 0)
                    
                } else {
                    middleColumn.topObject.center.x = middleMidLine
                    middleColumn.topObject.frame.origin.y = middleColumn.arrayOfObjects[0].frame.origin.y - middleColumn.topObject.frame.size.height

                    middleColumn.arrayOfObjects.insert(middleColumn.topObject, atIndex: 0)
                }
                
                
            } else if columnStart == 2 {
                NSLog("Move block from right to middle column")
            }
            
        } else if CGRectContainsPoint(rightColumn.frame, point!) {
            
            if columnStart == 1 {
                NSLog("Move block from middle to right column")
            }
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    

}

