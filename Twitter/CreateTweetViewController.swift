//
//  CreateTweetViewController.swift
//  Twitter
//
//  Created by Malik Browne on 2/23/16.
//  Copyright © 2016 Malik Browne. All rights reserved.
//

import UIKit

class CreateTweetViewController: UIViewController, UITextViewDelegate {
    
    var user: User!
    var charCount = 140
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self

        // Do any additional setup after loading the view.
        
        loadData()
        textView.becomeFirstResponder()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }
    
    func loadData() {
        if let profileImageUrl = user.profileImageUrl {
            profileImageView.setImageWithURL(NSURL(string: profileImageUrl)!)
        }
        nameLabel.text = user.name
        screenNameLabel.text = user.screenName
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return charCount > 0 || text == ""
    }
    
    
    
    func textViewDidChange(textView: UITextView) {
        charCount -= textView.text.characters.count
        characterCountLabel.text = "\(charCount)"
        charCount = 140
        
        if (textView.text.characters.count == 140) {
            charCount = 0
            return
        }
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.tweet(textView.text)
        navigationController!.popViewControllerAnimated(true)
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
