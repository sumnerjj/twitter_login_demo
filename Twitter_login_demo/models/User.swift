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
    var tagline: String?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(fileURLWithPath: profileUrlString)
        }
        tagline = dictionary["description"] as? String
        
    }
    
    //class var

}
