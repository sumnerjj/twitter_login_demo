//
//  ComposeViewController.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 9/29/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var tweetBody: String? = ""
    var replyToId: String = ""
    var replyUserName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("compose id: \(replyToId) replyusername: \(replyUserName)")
        
        if let replyUserName = replyUserName {
            composeTextView.text = "@\(replyUserName)"
        }
        else {
            composeTextView.text = "Placeholder"
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSendButton(_ sender: Any) {
        //self.tweetBody = composeTextView.text
        //print(self.tweetBody)
        //var paramsDict = NSMutableDictionary()
        //paramsDict["body"] = "qweqwe"
        print(composeTextView.text)
        TwitterClient.sharedInstance?.postNew(tweetText: composeTextView.text, replyToId: replyToId)
        
    }
    @IBOutlet weak var composeTextView: UITextView!

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
