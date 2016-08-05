//
//  ProfileViewController.swift
//  ProductivityAnalytics
//
//  Created by Brian Nguyen on 7/28/16.
//  Copyright © 2016 BrianNguyen. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var productivityPointsValue: UILabel!
    @IBOutlet weak var completionRateValue: UILabel!
    @IBOutlet weak var dailyTaskValue: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        usernameLabel.text = PFUser.currentUser()?.username

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "loggedOut"{
            
            PFUser.logOut()
        
        
        }
        
        
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
