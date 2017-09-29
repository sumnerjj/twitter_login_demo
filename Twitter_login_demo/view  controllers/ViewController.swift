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
        let client = TwitterClient.sharedInstance
        client?.login(success: { () -> () in
            print("logged in success")
        }, failure: { (error: Error) -> () in
            print("Error: \(error.localizedDescription)")
        })
        
    }
    
}

