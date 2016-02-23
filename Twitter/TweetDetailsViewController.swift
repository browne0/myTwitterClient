//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Malik Browne on 2/16/16.
//  Copyright © 2016 Malik Browne. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    var user: User!
    var selectedTweet: Tweet!
    var tweets: [Tweet]!
    var tweetID: Int!
    var indexPath: NSIndexPath!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileHandleLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadTweetView()
        
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }
    
    func loadTweetView() {
        profileNameLabel.text = user.name
        profileHandleLabel.text = "@\(user.screenName)"
        dateLabel.text = selectedTweet.createdAtString
        descriptionLabel.text = selectedTweet.text
        tweetID = selectedTweet.id
        favoriteCountLabel.text = String(selectedTweet.favoriteCount)
        retweetCountLabel.text = String(selectedTweet.retweetCount)
        
        let profileImageUrl = selectedTweet.user?.profileImageUrl
        profileImageView.setImageWithURL(NSURL(string: profileImageUrl!)!)
        
        if (selectedTweet.retweet == false) {
            retweetButton.setImage(UIImage(named: "retweet-action"), forState: .Normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: .Normal)
        }
        
        if (selectedTweet.favorite == false) {
            favoriteButton.setImage(UIImage(named: "like-action"), forState: .Normal)
        } else {
            favoriteButton.setImage(UIImage(named: "like-action-on"), forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func onProfileImageTap(sender: AnyObject) {
//        let button = sender as! UIButton
//        let view = button.superview!
//        let cell = view.superview as! TweetCell
//        selectedTweet = tweets![indexPath!.row]
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    
        let destinationViewController = segue.destinationViewController
        
        if let destinationViewController = destinationViewController as? ProfileViewController {
            destinationViewController.user = selectedTweet.user
        }
    }

}
