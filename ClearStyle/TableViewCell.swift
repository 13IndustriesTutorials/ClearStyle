//
//  TableViewCell.swift
//  ClearStyle
//
//  Created by user on 8/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import QuartzCore

//define a deletion protocol for the cell
protocol TableViewCellDelegate
{
    func toDoItemDeleted(toDoItem:ToDoItem)
    
    func toDoItemCompleted(toDoItem:ToDoItem)
}

class TableViewCell: UITableViewCell {

    var gradientLayer:CAGradientLayer
    var originalCenter:CGPoint
    var deleteOnDragRelease:Bool
    var markCompleteOnDragRelease:Bool
    var toDoItem:ToDoItem?
    var delegate:TableViewCellDelegate?
    
    var tickLabel:UILabel?
    var crossLabel:UILabel?
    
    let CuesMargin:CGFloat = 10.0
    let CuesWidth:CGFloat = 50.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        
        self.gradientLayer = CAGradientLayer()
        self.originalCenter = CGPointMake(0, 0)
        self.deleteOnDragRelease = false
        self.markCompleteOnDragRelease = false
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.gradientLayer.frame =  self.bounds //set frame to size of cell
        self.gradientLayer.colors = [UIColor(white: 1.0, alpha: 0.2),
            UIColor(white: 1.0, alpha: 0.1), UIColor.clearColor(),
            UIColor(white: 0.0, alpha: 0.1)
        ]
        self.gradientLayer.locations = [0.0, 0.1, 0.95, 1.00]
        self.layer.insertSublayer(self.gradientLayer, atIndex: 0)
        
        //create the cue labels
        self.tickLabel = self.createCueLabel()
        self.tickLabel!.text = "\u{2713}"  //checkmark
        self.tickLabel!.textAlignment = NSTextAlignment.Right
        self.addSubview(self.tickLabel)
        
        self.crossLabel = self.createCueLabel()
        self.crossLabel!.text =  "\u{2717}" //x mark
        self.crossLabel!.textAlignment = NSTextAlignment.Left
        self.addSubview(self.crossLabel)
        
        
        
        //create gesture recognizer
        let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        self.addGestureRecognizer(recognizer)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.gradientLayer.frame =  self.bounds
        self.tickLabel!.frame = CGRectMake(-self.CuesWidth - self.CuesMargin, 0, self.CuesWidth, self.bounds.size.height)
        self.crossLabel!.frame = CGRectMake(self.bounds.size.width + self.CuesMargin, 0, self.CuesWidth, self.bounds.size.height)
    }
    
    func createCueLabel() -> UILabel
    {
        var label = UILabel()
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(32.0)
        label.backgroundColor = UIColor.clearColor()
        return label
        
    }
    
    //override the gesture recognizer start
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool
    {
        var translation = (gestureRecognizer as UIPanGestureRecognizer).translationInView(self.superview)

        //check if th gesture is horizontal
        if fabsf(Float(translation.x)) > fabsf(Float(translation.y))
        {
            return true
        }
        
        return false
    }
    
    func handlePan(recognizer:UIPanGestureRecognizer)
    {
        if recognizer.state == UIGestureRecognizerState.Began
        {
            //set the current center when the pan begins
            self.originalCenter = self.center
        }
        
        if recognizer.state == UIGestureRecognizerState.Changed
        {
            //translate the center
            var translation = recognizer.translationInView(self)
            
            //only move the x coordinate for the pan
            self.center = CGPointMake(self.originalCenter.x + translation.x, self.originalCenter.y)
            
            //determine whether the item has been dragged far enough to complete
            self.markCompleteOnDragRelease = self.frame.origin.x > self.frame.size.width/2
            
            //determine whether the item has been dragged far enough to delete
            self.deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width/2
            
            var cueAlpha:CGFloat = fabs(self.frame.origin.x) / (self.frame.size.width / 2)
            self.tickLabel!.alpha =  cueAlpha
            self.crossLabel!.alpha = cueAlpha
            
            //set the color of the cue labels
            self.tickLabel!.textColor = self.markCompleteOnDragRelease ? UIColor.greenColor() : UIColor.whiteColor()
            self.crossLabel!.textColor = self.deleteOnDragRelease ? UIColor.redColor() : UIColor.whiteColor()
            
        }
        
        if recognizer.state == UIGestureRecognizerState.Ended
        {
            var originalFrame = CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height)
        
            //if the item is not being deleted, return to original position
            if !self.deleteOnDragRelease {
                UIView.animateWithDuration(0.2, animations: {
                    //animation
                    self.frame = originalFrame
                    })
            }
            
            if self.deleteOnDragRelease
            {
                
                if let item  = self.toDoItem
                {
                    self.delegate!.toDoItemDeleted(item)
                }
            }
            
            if self.markCompleteOnDragRelease
            {
                if let item  = self.toDoItem
                {
                    self.toDoItem!.completed = true
                    self.delegate?.toDoItemCompleted(item)
                }
                
            }
            

        }
    }

}



























