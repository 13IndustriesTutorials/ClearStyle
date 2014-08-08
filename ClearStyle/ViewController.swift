//
//  ViewController.swift
//  ClearStyle
//
//  Created by user on 8/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TableViewDataSource, TableViewCellDelegate {

    var toDoItems:[ToDoItem];
    var delegate:TableViewCellDelegate?

    @IBOutlet weak var tableView: TableView!

    
    required init(coder aDecoder: NSCoder!) {
        fatalError("NSCoding not supported")
    }
    
     override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {

        //create some default do to items
        self.toDoItems = [ToDoItem(text: "Feed the cat"),
            ToDoItem(text: "Buy eggs"),
            ToDoItem(text: "Pack bags for WWDC"),
            ToDoItem(text: "Rule the web"),
            ToDoItem(text: "Buy a new iPhone"),
            ToDoItem(text: "Find missing socks"),
            ToDoItem(text: "Write a new tutorial"),
            ToDoItem(text: "Master Swift"),
            ToDoItem(text: "Learn to draw"),
            ToDoItem(text: "Learn to juggle"),
            ToDoItem(text: "Find Mochi"),
            ToDoItem(text: "Have a snack"),
            ToDoItem(text: "Write some code"),
            ToDoItem(text: "Watch a little TV"),
        ToDoItem(text: "Give up")]
        
        //force the nibName to not be nil - beta 5 version release error
        let nib = nibNameOrNil ?? "TableView"
        super.init(nibName: nib, bundle: nibBundleOrNil)
//        super.init(nibName: nibName, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cellId")
        self.tableView.registerClassForCells(TableViewCell)
        
        self.tableView.dataSource = self
        
        //set the table view cell style
        self.tableView.backgroundColor = UIColor.blackColor()
        
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfRows() -> Int
    {
        return toDoItems.count
    }
    
    func cellForRow(row: Int) -> UIView
    {
        var cellIdentifier:String = "Cell"
        var cell:TableViewCell = TableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier:cellIdentifier)
        var item:ToDoItem = self.toDoItems[row]
        cell.toDoItem = item
        cell.textLabel.text = cell.toDoItem!.text
        cell.delegate = self
        cell.backgroundColor = self.colorForIndex(row)
        return cell
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
//    {
//        return 1
//    }
    
//    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
//    {
//        return self.toDoItems.count
//    }
    
//    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
//    {
//        let cellIdentifier = "cellId"
//        var cell:TableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? TableViewCell
//        
//        if cell == nil{
//            cell = TableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
//        }
//        
//        let toDoItem:ToDoItem = self.toDoItems[indexPath.item] as ToDoItem
//        
//        if toDoItem.completed{
//            //use strike through text
//            var key = String(NSStrikethroughStyleAttributeName)
//            var options = [key : NSUnderlineStyle.StyleSingle]
//            var attributedString = NSMutableAttributedString(string:toDoItem.text)
//            cell!.textLabel.attributedText =  attributedString
//            //cell!.textLabel.text = "Hey text updated!"//toDoItem.text
//        }
//        else{
//            cell!.textLabel.text = toDoItem.text
//        }
//        
//        //set the cell's delegate to the vc
//        cell!.delegate = self;
//        cell!.toDoItem = toDoItem;
//        
//        return cell
//    }
    
//    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!)
//    {
//        let toDoItem:ToDoItem = self.toDoItems[indexPath.item] as ToDoItem
//        
//        if toDoItem.completed{
//            cell.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0, alpha: 1.0)
//        }else {
//            cell.backgroundColor = self.colorForIndex(indexPath.row)
//        }
//    }
    
//    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
//    {
//        return 50.0
//    }
    
    //MARK: - Custom Method
    func colorForIndex(index:Int)->UIColor
    {
        let itemCount:Float = Float(self.toDoItems.count-1);
        let greenVal:CGFloat = CGFloat(Float(index) / itemCount) * 0.60
        let color = UIColor(red: 1.0, green: greenVal, blue: 0.0, alpha: 1.0)
        return color
    }

    //MARK: TableViewCell Delegate Method
    func toDoItemDeleted(toDoItem:ToDoItem)
    {
//        var index = (self.toDoItems as NSArray).indexOfObjectIdenticalTo(toDoItem)
//        self.toDoItems.removeAtIndex(index)
//        
//        var visibleCells:NSArray = self.tableView.visibleCells()
//        var lastView = visibleCells.lastObject as UIView
//        var startAnimating = false
//        var delay = 0.0
//        
//        for cell in visibleCells as [TableViewCell] {
//            
//            if startAnimating {
//                
//                UIView.animateWithDuration(0.3, delay: delay, options: UIViewAnimationOptions.CurveEaseInOut, animations:{
//                        cell.frame = CGRectOffset(cell.frame, 0.0, -cell.frame.size.height)
//                        
//                    } , completion:{
//                        (finished:Bool) in
//                        
//                        if cell == lastView {
//                            self.tableView.reloadData()
//                        }
//                        })
//                
//                delay += 0.03
//            }
//            
//            if cell.toDoItem == toDoItem
//            {
//                startAnimating = true
//                cell.hidden = true
//                
//            }
//        }
//
    }
    
     func toDoItemCompleted(toDoItem:ToDoItem)
     {
//        var index = (self.toDoItems as NSArray).indexOfObjectIdenticalTo(toDoItem)
//        self.tableView.beginUpdates()
//        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
//        self.tableView.endUpdates()
    }

}



















