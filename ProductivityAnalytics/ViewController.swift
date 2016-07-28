//
//  ViewController.swift
//  ProductivityAnalytics
//
//  Created by Brian Nguyen on 7/28/16.
//  Copyright © 2016 BrianNguyen. All rights reserved.
//

import UIKit
import Alamofire
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var enterButtonLabel: UIButton!
    
    @IBOutlet weak var switchLabel: UIButton!
    
    var signUpMode = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    func alertMessage(title: String, message: String){
        
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            self.dismissViewControllerAnimated(true, completion:nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }
    
    
    @IBAction func enterButton(sender: AnyObject) {
        
        
        if usernameLabel.text == "" || passwordLabel.text == "" {
            
            alertMessage("Error",  message: "Invalid username or password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var user = PFUser()
            user.username = usernameLabel.text
            user.password = passwordLabel.text

            if signUpMode == true {
                
                user.signUpInBackgroundWithBlock({ (success, error) in
                    
                    if error != nil {
                        
                        print(error)
                        
                    } else {
                        
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        self.performSegueWithIdentifier("loggedIn", sender: self)
                    }
                    
                    
                })
                
            } else {
                
                PFUser.logInWithUsernameInBackground(usernameLabel.text!, password: passwordLabel.text!, block: { (user, error) in
                    
                    if error != nil{
                        
                        print("error")
                        print(error)
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        
                    } else{
                        
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        self.performSegueWithIdentifier("loggedIn", sender: self)
                        
                        
                    }
                    
                    
                    
                })
                
                
                
            }

            
        }
        
        
    }
    
    
    @IBAction func switchButton(sender: AnyObject) {
       
        if signUpMode == true{
            
            enterButtonLabel.setTitle("Log In", forState: UIControlState.Normal)
            
            switchLabel.setTitle("Need an Account?", forState: UIControlState.Normal)

            
            signUpMode = false
            
        } else {
            
            
            enterButtonLabel.setTitle("Sign Up", forState: UIControlState.Normal)
            
            switchLabel.setTitle("Have an Account?", forState: UIControlState.Normal)
            
            
            signUpMode = true
            
        }
        

        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

