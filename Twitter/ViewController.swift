//
//  ViewController.swift
//  Twitter
//
//  Created by Malik Browne on 2/9/16.
//  Copyright © 2016 Malik Browne. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    var tweets: [Tweet]?
    
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginView.layer.cornerRadius = 3
        loginView.clipsToBounds = true
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                // perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // handle login error
            }
        }
    }
}

