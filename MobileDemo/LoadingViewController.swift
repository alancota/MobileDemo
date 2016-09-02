//
//  LoadingViewController.swift
//  MobileDemo
//
//  Created by Mike Moore on 8/23/16.
//  Copyright © 2016 Mike Moore. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var workingAnimation: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkStatus()
    }
    
    func checkStatus()
    {
        if MobileDemo.sharedInstance.getStatus() == .DidStart {
            workingAnimation.stopAnimating()
            statusLabel.text = "Securely Connected to API Gateway"
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("loadingComplete", sender: self)
            }
            
            return
        }
        if MobileDemo.sharedInstance.getStatus() == .NotInitialized {
            workingAnimation.stopAnimating()
            statusLabel.text = "Failed to Connect to API Gateway"
            return
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.checkStatus()
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

