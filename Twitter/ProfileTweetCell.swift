//
//  ProfileTweetCell.swift
//  Twitter
//
//  Created by Malik Browne on 2/22/16.
//  Copyright © 2016 Malik Browne. All rights reserved.
//

import UIKit

class ProfileTweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIButton!
    @IBOutlet weak var favoriteImageView: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweetID: Int!
    
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet.user!.name
            handleLabel.text = "@\(tweet.user!.screenName)"
            createdAtLabel.text = tweet.createdAtString
            descriptionLabel.text = tweet.text
            tweetID = tweet.id
            let profileImageUrl = tweet.user?.profileImageUrl
            profileImageView.setImageWithURL(NSURL(string: profileImageUrl!)!)
            
            if (tweet.retweet == false) {
                
                retweetImageView.setImage(UIImage(named: "retweet-action"), forState: .Normal)
                
            } else {
                
                retweetImageView.setImage(UIImage(named: "retweet-action-on"), forState: .Normal)
                
            }
            
            if (tweet.favorite == false) {
                
                favoriteImageView.setImage(UIImage(named: "like-action"), forState: .Normal)
                
            } else {
                
                favoriteImageView.setImage(UIImage(named: "like-action-on"), forState: .Normal)
                
            }
            
            favoriteCountLabel.text = String(tweet.favoriteCount)
            retweetCountLabel.text = String(tweet.retweetCount)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        if (retweetImageView.imageView?.image == UIImage(named:"retweet-action"))
        {
            TwitterClient.sharedInstance.retweet(tweetID)
            retweetImageView.setImage(UIImage(named: "retweet-action-on"), forState: .Normal)
            retweetCountLabel.text = String(tweet.retweetCount + 1)
        }
            
        else if (retweetImageView.imageView?.image == UIImage(named: "retweet-action-on"))
        {
            TwitterClient.sharedInstance.unretweet(tweetID)
            retweetImageView.setImage(UIImage(named: "retweet-action"), forState: .Normal)
            retweetCountLabel.text = String(tweet.retweetCount)
        }
    }
    
    @IBAction func onLike(sender: AnyObject) {
        if (favoriteImageView.imageView?.image == UIImage(named: "like-action"))
        {
            TwitterClient.sharedInstance.favoriteTweet(tweetID)
            favoriteImageView.setImage(UIImage(named: "like-action-on"), forState: .Normal)
            favoriteCountLabel.text = String(tweet.favoriteCount + 1)
        }
            
        else if (favoriteImageView.imageView?.image == UIImage(named: "like-action-on"))
        {
            TwitterClient.sharedInstance.unfavoriteTweet(tweetID)
            favoriteImageView.setImage(UIImage(named: "like-action"), forState: .Normal)
            favoriteCountLabel.text = String(tweet.favoriteCount)
        }
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
