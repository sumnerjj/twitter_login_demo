//
//  profileViewController.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 10/4/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]?
    var profileUser = User.currentUser
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //profileUser = User.currentUser
        coverImage.setImageWith((profileUser?.coverUrl)!)
        profileImage.setImageWith((profileUser?.profileUrl)!)
        followersCountLabel.text = "Followers: \(profileUser!.followers!)"
        tweetCountLabel.text = "Tweets: \(profileUser!.tweetCount!)"
        friendsCountLabel.text = "Following: \(profileUser!.friends!)"
        tableView.dataSource = self
        tableView.delegate = self
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refreshControlAction), for: UIControlEvents.valueChanged)
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        tableView.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets{
            return tweets.count
        }
        else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets![indexPath.row]
        cell.tweetLabel.text = tweet.text
        print(cell.tweetLabel.text!)
        print(tweet.profileUrl!)
        cell.profileImage.setImageWith(tweet.profileUrl!)
        cell.usernameLabel.text = tweet.user?.screenName!
        cell.timeStampLabel.text = tweet.timeSince
        return cell
    }
    
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        User.currentUser = nil
        TwitterClient.sharedInstance?.logout()
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("list segue")
        if let cell = sender as? UITableViewCell{
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets?[(indexPath?.row)!]
            let detailViewController = segue.destination as! TweetDetailViewController
            detailViewController.tweet = tweet
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
