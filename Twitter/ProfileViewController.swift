//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Malik Browne on 2/22/16.
//  Copyright © 2016 Malik Browne. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bannerView: UIImageView!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var tweetFollowingLabel: UILabel!
    @IBOutlet weak var tweetFollowersLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    var selectedTweet: Tweet!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        createView()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        profileImageVIew.layer.cornerRadius = 3
        profileImageVIew.clipsToBounds = true
        
        loadData()
    }
    
    func createView() {
        if let bannerImageUrl = user.bannerImageUrl {
            bannerView.setImageWithURL(NSURL(string: bannerImageUrl)!)
        }
        
        if let profileImageUrl = user.profileImageUrl {
            profileImageVIew.setImageWithURL(NSURL(string: profileImageUrl)!)
        }
        
        nameLabel.text = user.name
        handleLabel.text = user.screenName
        tweetCountLabel.text = String(user.tweetCount)
        tweetFollowingLabel.text = String(user.followingCount)
        tweetFollowersLabel.text = String(user.followersCount)
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = bannerView.bounds
        bannerView.addSubview(blurView)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTweetCell", forIndexPath: indexPath) as! ProfileTweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedTweet = tweets![indexPath.row]
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func loadData() {
        TwitterClient.sharedInstance.userTimeLineWithParams(["screen_name": user.screenName!], completion: { (tweets, error) -> () in
            
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let viewController = segue.destinationViewController
        if let viewController = viewController as? TweetDetailsViewController {
            viewController.selectedTweet = selectedTweet
            viewController.user = selectedTweet.user
        }
        
        else if let viewController = viewController as? CreateTweetViewController {
            viewController.user = User.currentUser
        }
        
    }


}
