//
//  TweetsViewController.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 9/28/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tweets: [Tweet]?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.profileImage.isUserInteractionEnabled = true
        cell.profileImage.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        //print("image tapped: \(tappedImage.superview?.superview)")
        let tapLocation = tapGestureRecognizer.location(in: self.tableView)
        
        //using the tapLocation, we retrieve the corresponding indexPath
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)
        let tweet = tweets![(indexPath?.row)!] as! Tweet
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userProfileController = storyboard.instantiateViewController(withIdentifier: "userProfileController") as! ProfileViewController
        userProfileController.profileUser = tweet.user
        print(userProfileController.profileUser!.screenName)
        present(userProfileController, animated: true, completion: nil)
        print(tweet.user?.screenName)
        
        //finally, we print out the value
        //print(indexPath)
        
        //we could even get the cell from the index, too
        //let cell = self.tableView.cellForRow(at: indexPath!) as! TweetCell
        
        //print(cell.usernameLabel)
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
