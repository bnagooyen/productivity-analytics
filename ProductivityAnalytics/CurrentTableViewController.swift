//
//  CurrentTableViewController.swift
//  ProductivityAnalytics
//
//  Created by Brian Nguyen on 7/29/16.
//  Copyright © 2016 BrianNguyen. All rights reserved.
//

import UIKit
import Parse




class CurrentTableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
  
    var tasks = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

       var query = PFQuery(className: "Task")
       query.whereKey("userId", equalTo: (PFUser.currentUser()?.objectId)!)
       query.whereKey("completed", equalTo: false)
        
       query.findObjectsInBackgroundWithBlock { (objects, error) in
        
            if let objects = objects {
            
                
                for object in objects{
                    
                    self.tasks.append(object)
                    self.table.reloadData()
                    
                }
            
            
            }
        
        
        
        
        
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel!.text = tasks[indexPath.row]["taskName"] as! String

        return cell
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
            table.reloadData()
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailSegue"{
            
            let destination = segue.destinationViewController as? TaskDetailViewController
            let selectedRow = table.indexPathForSelectedRow?.row
                       
            destination?.tasks = self.tasks
            destination?.count = selectedRow!
        }
        
        
    }
    
   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
