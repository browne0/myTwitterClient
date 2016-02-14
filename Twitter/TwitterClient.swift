//
//  TwitterClient.swift
//  Twitter
//
//  Created by Malik Browne on 2/9/16.
//  Copyright © 2016 Malik Browne. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "OntCGAzLKKqbxGiGOAa0ZKAxx"
let twitterConsumerSecret = "afEbTOvI2KGCqLSpysMcOw4sMmy9jPWHrw6ZU2Qswscf7QXJf7"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com/")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimeLineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]!, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
//            print("home timeline: \(response)")
            let tweets = Tweet.tweetswithArray(response as! [NSDictionary])
            
//            for tweet in tweets {
//                print("created: \(tweet.retweetCount)")
//            }
            completion(tweets: tweets, error: nil)
        }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
            print("error getting home timeline")
            completion(tweets: nil, error: error)
        })
        
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
        }) { (error: NSError!) -> Void in
            print("Failed to get request token")
            self.loginCompletion?(user: nil, error: error)
        }

    }
    
    func openUrl(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                // print("user: \(response)")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }

    }
    
    func retweet(id: Int) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation, response) -> Void in
            print("succesfully retweeted!")
            
            }, failure: { (operation, error) -> Void in
                print("error retweeting")
        })
    }
    
    func favoriteTweet(id: Int) {
        POST("1.1/favorites/create.json", parameters: ["id": id], success: { (operation, response) -> Void in
            print("succesfully favorited!")
            
            }, failure: { (operation, error) -> Void in
                print("error favoriting")
        })
    }
    
    func unretweet(id: Int) {
        POST("1.1/statuses/unretweet/\(id).json", parameters: nil, success: { (operation, response) -> Void in
            print("successfully unretweeted!")
            }, failure: { (operation, error) -> Void in
                print("error unretweeting")
        })
    }

    func unfavoriteTweet(id: Int) {
        POST("1.1/favorites/destroy.json", parameters: ["id": id], success: { (operation, response) -> Void in
            print("successfully unfavorited!")
            }, failure: { (operation, error) -> Void in
                print("error unfavoriting")
        })
    }
}
