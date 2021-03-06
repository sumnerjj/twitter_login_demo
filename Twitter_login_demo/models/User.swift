//
//  User.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 9/28/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name : String?
    var screenName : String?
    var profileUrl : URL?
    var coverUrl: URL?
    var tagline: String?
    var friends: Int?
    var followers: Int?
    var tweetCount: Int?
    
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        friends = dictionary["friends_count"] as? Int
        followers = dictionary["followers_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        let coverImageUrlString = dictionary["profile_background_image_url_https"] as? String
        if let coverImageUrlString = coverImageUrlString {
            coverUrl = URL(string: coverImageUrlString)
        }
        tagline = dictionary["description"] as? String
        
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults: UserDefaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUSer") as? Data
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }

        set(user){
            _currentUser = user
            let defaults: UserDefaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUSer")
            }
            else {
                defaults.set(nil, forKey: "currentUser")
            }
            defaults.synchronize()
        }
    }

}
