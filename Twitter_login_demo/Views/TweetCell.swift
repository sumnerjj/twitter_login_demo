//
//  TweetCell.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 9/29/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var tweet: Tweet! {
        didSet{
            usernameLabel.text = tweet.user!.name
            print("image url: \(tweet.profileUrl)")
            profileImage.setImageWith(tweet.profileUrl!)
            if let imageURL = tweet.user!.profileUrl {
                profileImage.setImageWith(imageURL)
                print("image url: \(imageURL)")
            }
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
