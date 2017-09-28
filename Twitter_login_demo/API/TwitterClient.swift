//
//  TwitterClient.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 9/28/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "pPWSqAYRw8ZzEUxU1oLCnzv04", consumerSecret: "2lv9eClYqFRq6sWWv88b8s7JltwiNYDZWhwyRERFtypyFdPSXz")
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> () ){

        
        get("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: {(task: URLSessionTask?, error: Error) -> Void in
            failure(error)
        })
        
    }
    
    func currentAccount() {
        
        get("1.1/account/verify_credentials.json", parameters: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            print("asd name: \(user.name)")
        }, failure: nil)
        
    }

}
