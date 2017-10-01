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

    @IBAction func retweetButton(_ sender: Any) {
        TwitterClient.sharedInstance?.retweet(tweet: tweet)
    }
    @IBAction func replyButton(_ sender: Any) {
    }
    @IBAction func starButton(_ sender: Any) {
        TwitterClient.sharedInstance?.favorite(tweet: tweet)
    }
    @IBOutlet weak var replyIcon: UIButton!
    @IBOutlet weak var retweetIcon: UIButton!
    @IBOutlet weak var starIcon: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        let retweetImage = UIImage(named: "retweet")
        retweetIcon.setImage(retweetImage, for: UIControlState.normal)
        let replyImage = UIImage(named: "reply")
        replyIcon.setImage(replyImage, for: UIControlState.normal)
        let starImage = UIImage(named: "star")
        starIcon.setImage(starImage, for: UIControlState.normal)
        //starIcon.image = UIImage(named: "star")
        //replyIcon.image = UIImage(named: "reply")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("detail view segue")
        if let button = sender as? UIButton{
            let tweetId = self.tweet.id!
            let tweetUser = self.tweet.user?.screenName
            print("tweet id: \(tweetId)")
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.replyToId = tweetId
            composeViewController.replyUserName = tweetUser
        }
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
