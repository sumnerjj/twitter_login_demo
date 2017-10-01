//
//  TweetDetailViewController.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 9/30/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet!

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var replyIcon: UIImageView!
    @IBOutlet weak var retweetIcon: UIImageView!
    override func viewDidLoad() {
        retweetIcon.image = UIImage(named: "retweet")
        starIcon.image = UIImage(named: "star")
        replyIcon.image = UIImage(named: "reply")
        super.viewDidLoad()
        statusLabel.text = tweet.text
        print(tweet)
        print("user: \(String(describing: tweet.user))")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
