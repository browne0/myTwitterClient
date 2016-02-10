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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: { (tweets, error) -> () in
        
            self.tweets = tweets
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
                // perform segue
            } else {
                // handle login error
            }
        }
    }
}

