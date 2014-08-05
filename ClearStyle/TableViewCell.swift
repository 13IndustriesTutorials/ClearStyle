//
//  TableViewCell.swift
//  ClearStyle
//
//  Created by user on 8/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit
import QuartzCore

class TableViewCell: UITableViewCell {

    var gradientLayer:CAGradientLayer
    var originalCenter:CGPoint
    var deleteOnDragRelease:Bool
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        
        self.gradientLayer = CAGradientLayer()
        self.deleteOnDragRelease = false;
        self.originalCenter = CGPointMake(0, 0)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.gradientLayer.frame =  self.bounds //set frame to size of cell
        self.gradientLayer.colors = [UIColor(white: 1.0, alpha: 0.2),
            UIColor(white: 1.0, alpha: 0.1), UIColor.clearColor(),
            UIColor(white: 0.0, alpha: 0.1)
        ]
        self.gradientLayer.locations = [0.0, 0.1, 0.95, 1.00]
        self.layer.insertSublayer(self.gradientLayer, atIndex: 0)
        
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
            
            //determine whether the item has been dragged far enough to delete
            self.deleteOnDragRelease = self.frame.origin.x < -self.frame.size.width/2
        }
        
        if recognizer.state == UIGestureRecognizerState.Ended
        {
            var originalFrame = CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height)
            if !self.deleteOnDragRelease {
                UIView.animateWithDuration(0.2, animations: {
                    //animation
                    self.frame = originalFrame
                    })
            }
        }
    }
    
}



























