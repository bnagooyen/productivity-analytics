//
//  LogTaskViewController.swift
//  ProductivityAnalytics
//
//  Created by Brian Nguyen on 7/29/16.
//  Copyright © 2016 BrianNguyen. All rights reserved.
//

import UIKit
import Parse


class LogTaskViewController: UIViewController {

    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
   
      var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeStepperValue(sender: AnyObject) {
        
        timeLabel.text = String(stepper.value)
        
    }
    
    @IBAction func submitButton(sender: AnyObject) {
        
        
        
        var task = PFObject(className: "Task")
        task["userId"] = PFUser.currentUser()?.objectId
        task["taskName"] = taskNameField.text
        task["date"] = datePicker.date
        task["lengthOfTime"] = stepper.value
        task["completed"] = true 
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()

        
        task.saveInBackgroundWithBlock { (success, error) in
            
            if error != nil {
                
                print("error")
                
            } else {
                
                print("success!")
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.taskNameField.text = ""
                self.stepper.value = 0
                self.timeLabel.text = "0"
                
            }
    
            
            
        }
        
        
        
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
