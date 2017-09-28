//    https://api.twitter.com/oauth/access_token//
//  ViewController.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 9/26/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnLoginButton(_ sender: Any) {
        print("asd")
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "mytwitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print("I got a token \(requestToken.token)")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token!)")
            UIApplication.shared.openURL(url!)
        }, failure: {(error: Error!) -> Void in
            print("error: \(error.localizedDescription)")
        })
    }
    
}

