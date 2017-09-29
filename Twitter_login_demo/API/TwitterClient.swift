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
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        print("asd")
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "mytwitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("I got a token \(requestToken.token)")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")
            UIApplication.shared.openURL(url!)
        }, failure: {(error: Error!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        })
        
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "https://api.twitter.com/oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential!) -> Void in
            print("I got access token")
            
            self.loginSuccess?()
            
            /*client?.currentAccount()
            
            client?.homeTimeline(success: { (tweets: [Tweet]) in
                for tweet in tweets {
                    print("asd \(tweet.text)")
                }
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            }) */

        }, failure: {(error: Error!) -> Void in
            print("error qwe")
            self.loginFailure?(error)
        })
    }
    
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