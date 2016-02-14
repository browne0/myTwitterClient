//
//  Tweet.swift
//  Twitter
//
//  Created by Malik Browne on 2/10/16.
//  Copyright © 2016 Malik Browne. All rights reserved.
//

import UIKit
import Timepiece

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var favoriteCount: Int!
    var retweetCount: Int!
    var id: Int?
    var retweet: Bool?
    var favorite: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as? Int
        retweet = dictionary["retweeted"] as? Bool
        favorite = dictionary["favorited"] as? Bool
        
//        String twitterFormat = "EEE MMM dd HH:mm:ss ZZZZZ yyyy";
//        SimpleDateFormat sf = new SimpleDateFormat(twitterFormat, Locale.ENGLISH);
//        sf.setLenient(true);
//        String relativeDate = "";
//        
//        try {
//            long dateMillis = sf.parse(rawJsonDate).getTime();
//            relativeDate = DateUtils.getRelativeTimeSpanString(dateMillis,
//                System.currentTimeMillis(), DateUtils.SECOND_IN_MILLIS, DateUtils.FORMAT_ABBREV_RELATIVE).toString();
//        } catch (ParseException e) {
//            e.printStackTrace();
//        }
        
        let twitterFormat = NSDateFormatter()
        //Wed Dec 01 17:08:03 +0000 2010
        
        twitterFormat.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = twitterFormat.dateFromString(createdAtString!)

        twitterFormat.dateFormat = "EEE MMM d h:mm a"
        createdAtString = twitterFormat.stringFromDate(createdAt!)
        
        favoriteCount = dictionary["favorite_count"] as? Int
        retweetCount = dictionary["retweet_count"] as? Int
    }
    
    class func tweetswithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
}
