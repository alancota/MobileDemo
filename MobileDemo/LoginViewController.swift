//
//  LoginViewController.swift
//  MobileDemo
//
//  Created by Mike Moore on 8/24/16.
//  Copyright © 2016 Mike Moore. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginActivity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loginActivity.stopAnimating()
        loginBtn.hidden = false
        userField.enabled = true
        passField.enabled = true
        userField.text = ""
        passField.text = ""

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(MASUser.currentUser() != nil && MASUser.currentUser().isAuthenticated)
        {
            self.performSegueWithIdentifier("loginComplete", sender: self)
        }

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(textField == passField)
        {
            doLogin()
        }
        return true
    }

    // Perform MAS Login
    @IBAction func doLogin()
    {
        loginActivity.startAnimating()
        loginBtn.hidden = true
        userField.enabled = false
        passField.enabled = false
        MASUser.loginWithUserName(userField.text!, password: passField.text!) { (complete: Bool, error: NSError!) in
            self.loginActivity.stopAnimating()
            if(error != nil)
            {
                let alertController = UIAlertController(title: "Login Failed", message:
                    error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                self.loginBtn.hidden = false
                self.userField.enabled = true
                self.passField.enabled = true
                return
            }
            if(MASUser.currentUser() != nil && MASUser.currentUser().isAuthenticated)
            {
                self.performSegueWithIdentifier("loginComplete", sender: self)
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
