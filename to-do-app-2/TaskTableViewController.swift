//
//  TaskTableViewController.swift
//  to-do-app-2
//
//  Created by Lucas Alves Sobrinho on 2/20/16.
//  Copyright © 2016 Lucas Alves Sobrinho. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    // MARK: properties
    var tasks = [Task]()
    var editingTask: Task?
    var i: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTasks()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.view.addGestureRecognizer(longPressRecognizer)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            let touchPoint = longPressGestureRecognizer.locationInView(self.view)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                i = indexPath.row
                editingTask = tasks[i!]
                performSegueWithIdentifier("EditTask", sender: self)
            }
        }
    }
    
    func removeOldTasks() {
        var i: Int
        var c = [Int]()
        for i = 0; i < tasks.count; i++ {
            let task = tasks[i]
            let dateDifference = NSCalendar.currentCalendar().components(
                [.Minute],
                fromDate: task.dateCompleted ?? NSDate(),
                toDate: NSDate(),
                options: [])
            if dateDifference.minute > 1440 && task.status {
                c.append(i)
            }
        }
        for i = 0; i < c.count; i++ {
            tasks.removeAtIndex(c[i] - i)
        }
        saveTasks()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TaskTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        
        cell.nameLabel.text = task.name
        if task.status {
            cell.accessoryType = .Checkmark;
            cell.nameLabel.textColor = UIColor.lightGrayColor()
        } else {
            cell.accessoryType = .None;
            cell.nameLabel.textColor = UIColor.blackColor()
        }
        
        return cell
    }
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? TaskViewController, task = sourceViewController.task {
            let newIndexPath = NSIndexPath(forRow: tasks.count, inSection: 0)
            tasks.append(task)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            saveTasks()
        }
        if let sourceViewController = sender.sourceViewController as? EditTaskViewController, task = sourceViewController.task, i = sourceViewController.i {
            tasks[i] = task
            saveTasks()
            self.tableView.reloadData()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tasks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveTasks()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if !tasks[indexPath.row].status {
            tasks[indexPath.row].dateCompleted = NSDate()
        } else {
            tasks[indexPath.row].dateCompleted = nil
        }
        tasks[indexPath.row].status = !tasks[indexPath.row].status
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TaskTableViewCell
        if tasks[indexPath.row].status {
            cell.accessoryType = .Checkmark;
            cell.nameLabel.textColor = UIColor.lightGrayColor()
        } else {
            cell.accessoryType = .None;
            cell.nameLabel.textColor = UIColor.blackColor()
        }
        saveTasks()
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "statsSegue") {
            let statsVC = segue.destinationViewController as! StatsViewController;
            statsVC.tasks = tasks
        }
        if (segue.identifier == "EditTask") {
            let nav = segue.destinationViewController as! UINavigationController
            let editVC = nav.topViewController as! EditTaskViewController
            editVC.task = editingTask
            editVC.i = i
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = tasks[indexPath.row].color
    }
    
    func saveTasks() {
        let myData = NSKeyedArchiver.archivedDataWithRootObject(tasks)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "tasks")
    }
    
    func loadTasks(){
        let taskData = NSUserDefaults.standardUserDefaults().objectForKey("tasks") as? NSData
        if let taskData = taskData {
            let taskArray = NSKeyedUnarchiver.unarchiveObjectWithData(taskData) as? [Task]
            
            if let taskArray = taskArray {
                var i = 0
                for i = 0; i < taskArray.count; i++ {
                    tasks = taskArray
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        removeOldTasks()
    }
    
}
