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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        
        self.gradientLayer = CAGradientLayer()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.gradientLayer.frame =  self.bounds //set frame to size of cell
        self.gradientLayer.colors = [UIColor(white: 1.0, alpha: 0.2),
            UIColor(white: 1.0, alpha: 0.1), UIColor.clearColor(),
            UIColor(white: 0.0, alpha: 0.1)
        ]
        self.gradientLayer.locations = [0.0, 0.1, 0.95, 1.00]
        self.layer.insertSublayer(self.gradientLayer, atIndex: 0)
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
    
}
