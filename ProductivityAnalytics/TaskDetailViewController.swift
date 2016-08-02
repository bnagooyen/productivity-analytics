//
//  TaskDetailViewController.swift
//  ProductivityAnalytics
//
//  Created by Brian Nguyen on 7/31/16.
//  Copyright © 2016 BrianNguyen. All rights reserved.
//

import UIKit
import Parse

class TaskDetailViewController: UIViewController {

    var tasks = [PFObject]()
    var count = 0 
    
    @IBOutlet weak var taskName: UILabel!
   
    @IBOutlet weak var dateLoggedLabel: UILabel!
    
    @IBOutlet weak var timeComittedLabel: UILabel!
    
    @IBOutlet weak var completionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskName.text = String(tasks[count]["taskName"])
        dateLoggedLabel.text = String(tasks[count]["date"])
        timeComittedLabel.text = String(tasks[count]["lengthOfTime"])
        completionLabel.text = String(tasks[count]["completed"])
      
    }
    
    func completionAlert(){
        
        var completionAlert = UIAlertController(title: "Completed", message: "Have you completed your committed task?", preferredStyle: UIAlertControllerStyle.Alert)
        
       
        completionAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action) in
            print("pre query test")
            var query = PFQuery(className: "Task")
            query.whereKey("objectId", equalTo: self.tasks[self.count].objectId!)
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) in
                
                if error != nil{
                    
                    print(error)
                    
                } else {
                    
                    print("before if let objects = objects test")
                    
                    if let objects = objects {
                        print("gets objects")
                        print(objects)
                        for object in objects{
                            
                            object["completed"] = true
                            object.saveInBackground()
                            print("gets here")
                            
                        }
                        
                    }
                    
                }
                
                
            })
        
        
            
        }))
        
        completionAlert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: {(action) in
            
            print("nah")
            
        }))
        
        presentViewController(completionAlert, animated: true, completion: nil)
    }

    @IBAction func completeButton(sender: AnyObject) {
        
        
        completionAlert()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
