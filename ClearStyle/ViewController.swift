//
//  ViewController.swift
//  ClearStyle
//
//  Created by user on 8/4/14.
//  Copyright (c) 2014 someCompanyNameHere. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var toDoItems:[AnyObject];
    
    @IBOutlet weak var tableView: UITableView!
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
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
        ToDoItem(text: "Give up")]
        super.init(nibName: nibName, bundle: nibBundleOrNil)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set the table view cell style
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.toDoItems.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        let cellIdentifier = "cellID"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        let toDoItem:ToDoItem = self.toDoItems[indexPath.item] as ToDoItem
        cell!.textLabel.text = toDoItem.text
        return cell
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        cell.backgroundColor = self.colorForIndex(indexPath.row)
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
    {
        return 50.0
    }
    
    //MARK: - Custom Method
    func colorForIndex(index:Int)->UIColor
    {
        let itemCount:Float = Float(self.toDoItems.count-1);
        let greenVal:CGFloat = CGFloat(Float(index) / itemCount) * 0.60
        let color = UIColor(red: 1.0, green: greenVal, blue: 0.0, alpha: 1.0)
        return color
    }


}



















