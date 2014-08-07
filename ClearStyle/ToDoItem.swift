//
//  ToDoItem.swift
//  ClearStyle
//
//  Created by user on 8/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {
   
    var text:String
    var completed:Bool
    
    override init()
    {
        self.text = "";
        self.completed = false;
        super.init()
    }
    
    init(text:String)
    {
        self.text = text;
        self.completed = false;
        super.init()
    }
    
}
