//
//  TableView.swift
//  ClearStyle
//
//  Created by user on 8/6/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit


protocol TableViewDataSource
{
    func numberOfRows()->Int
    
    func cellForRow(row:Int)->UIView
}

class TableView: UIView, UIScrollViewDelegate {

    var scrollView:UIScrollView
    var dataSource:TableViewDataSource?
    let RowHeight:CGFloat = 50.0
    var cellClass:AnyClass?
    var reuseCells:NSMutableSet
    
    override init(frame: CGRect) {
        
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.reuseCells = NSMutableSet()
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(self.scrollView)
    }
    
    
    required init(coder aDecoder: NSCoder!)
    {
        self.scrollView = UIScrollView()
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.reuseCells = NSMutableSet()
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(self.scrollView)
    }
    
    override func layoutSubviews()
    {
        self.scrollView.frame = self.frame
        self.refreshView()
    }

    func refreshView()
    {

        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, CGFloat(self.dataSource!.numberOfRows()) * self.RowHeight )
        
        let rows = self.dataSource!.numberOfRows()
        var index:Int
        
        for index in 1...rows {
            var cell = self.dataSource?.cellForRow(index)
            var topEdgeForRow =  CGFloat(index) * self.RowHeight
            var frame = CGRectMake(0, topEdgeForRow, self.scrollView.frame.size.width, self.RowHeight)
            cell!.frame = frame
            self.scrollView.addSubview(cell!)
        }
    }
    
    func setDataSource(dataSource:TableViewDataSource)
    {
        self.dataSource =  dataSource
        self.refreshView()
    }
    
    func registerClassForCells(cellClass:AnyClass)
    {
        self.cellClass = cellClass
    }
    
}






































