//
//  ViewController.swift
//  myTouchOne
//
//  Created by Richard Oros on 20/03/2017.
//  Copyright © 2017 Richard Oros. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class LoginViewController: UIViewController {
    

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
       
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // If we have the uid stored, the user is already logger in - no need to sign in again!
        
        if UserDefaults.standardUserDefaults.valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            self.performSegue(withIdentifier: "CurrentlyLoggedIn", sender: nil)
        }
    }
    @IBAction func tryLogin(sender: AnyObject) {
        
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            
            // Login with the Firebase's authUser method
            
            DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error)
                    self.loginErrorAlert("Oops!", message: "Check your username and password.")
                } else {
                    
                    // Be sure the correct uid is stored.
                    
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // Enter the app!
                    
                    self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
                }
            })
            
        } else {
            
            // There was a problem
            
            loginErrorAlert(title: "Oops!", message: "Don't forget to enter your email and password.")
        }
    }
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    
    func loginErrorAlert(title: String, message: String) {
        
        // Called upon login error to let the user know login didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logout(sender: AnyObject) {
        
        // unauth() is the logout method for the current user.
        
        DataService.dataService.CURRENT_USER_REF.unauth()
        
        // Remove the user's uid from storage.
        
        UserDefaults.standard.setValue(nil, forKey: "uid")
        
        // Head back to Login!
        
        let loginViewController = self.storyboard!.instantiateViewController(withIdentifier: "Login")
        UIApplication.sharedApplication.keyWindow?.rootViewController = loginViewController
    }
    
    
    
}
