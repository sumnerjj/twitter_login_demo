//
//  Tweet.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 9/28/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text : String?
    var timeStamp : Date?
    var timeSince : String?
    var retweetCount : Int = 0
    var favoritesCount : Int = 0
    var user : User?
    var id : String?
    var profileUrl : URL?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        id = dictionary["id_str"] as? String

        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timeStampString)
            let elapsed = Date().timeIntervalSince(timeStamp!)
            let seconds = Int(elapsed)
            let hours = seconds / 3600
            timeSince = "\(hours)h"
        }
        
        if let user = dictionary["user"] as? NSDictionary {
            self.user = User(dictionary: user)
            self.profileUrl = self.user?.profileUrl
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
}
