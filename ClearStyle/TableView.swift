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

        if CGRectIsNull(self.scrollView.frame)
        {
            return
        }
        
        //set thte scroll view height
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, CGFloat(self.dataSource!.numberOfRows()) * self.RowHeight )
        
        //remove cells that are no longer visible
        for cell in self.cellSubviews()
        {
          if cell.frame.origin.y + cell.frame.size.height < self.scrollView.contentOffset.y
          {
             self.recycleCell(cell as TableViewCell)
            
          }
            
            if cell.frame.origin.y > self.scrollView.contentOffset.y + self.scrollView.frame.size.height
            {
                self.recycleCell(cell as TableViewCell)
            }
        }
        
        var firstVisibleIndex:Int = Int(max(0, floor(self.scrollView.contentOffset.y / self.RowHeight)))
        var lastVisibleIndex:Int = Int(min(self.dataSource!.numberOfRows(), firstVisibleIndex + 1 + Int(ceil(self.scrollView.frame.height / self.RowHeight))))
        
        
        for index in firstVisibleIndex ..< lastVisibleIndex
        {
            var cell = self.cellForRow(index)
            
            if cell != nil
            {
                var cell = self.dataSource?.cellForRow(index)
                var topEdgeForRow = CGFloat(index) * self.RowHeight
                cell?.frame = CGRectMake(0, topEdgeForRow, self.scrollView.frame.size.width, self.RowHeight)
                self.scrollView.insertSubview(cell!, atIndex: 0)
            }
        }
        
//        let rows = self.dataSource!.numberOfRows()
//        
//        for index in 1...rows {
//            var cell = self.dataSource?.cellForRow(index)
//            var topEdgeForRow =  CGFloat(index) * self.RowHeight
//            var frame = CGRectMake(0, topEdgeForRow, self.scrollView.frame.size.width, self.RowHeight)
//            cell!.frame = frame
//            self.scrollView.addSubview(cell!)
//        }
    }
    
    //recycle cells by addin g it to the set of reuse cells and removing it from the view
    func recycleCell(cell:TableViewCell)
    {
        self.reuseCells.addObject(cell)
        cell.removeFromSuperview()
    }
    
    //the scroll view cells that are visible
    func cellSubviews()->NSArray
    {
        var cells = [TableViewCell]()
        
        for subview in self.scrollView.subviews
        {
            if subview.isKindOfClass(TableViewCell)
            {
                cells.append(subview as TableViewCell)
            }
        }
        
        return cells
    }
    
    //return the cell for a given row or nil if it does not exist
    func cellForRow(row:Int)->UIView?
    {
        var topEdgeRow = CGFloat(row) * self.RowHeight
        
        for cell in self.subviews
        {
            if cell.frame.origin.y == topEdgeRow
            {
                return cell as TableViewCell
            }
        }
        
        return nil
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






































