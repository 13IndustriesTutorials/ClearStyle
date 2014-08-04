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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    //MARK: - Navigation


}
