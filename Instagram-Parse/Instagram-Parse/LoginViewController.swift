//
//  LoginViewController.swift
//  Instagram-Parse
//
//  Created by Senyang Zhuang on 2/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onSignIn(sender: AnyObject) {
        

        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }
        }
            
        
    }
    
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        
        newUser.username = usernameField.text!
        newUser.password = passwordField.text!
        
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success  {
                print("Yay, created a user!")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }else{
                print(error!.localizedDescription)
                
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
