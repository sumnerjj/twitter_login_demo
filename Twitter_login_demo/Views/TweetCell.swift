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
    var tweet: Tweet! {
        didSet{
            usernameLabel.text = tweet.user!.name
            let asd = URL(fileURLWithPath: "http://pm1.narvii.com/6531/723ff69e490b5111e2a9faf003b9048369de7a9b_128.jpg")
            profileImage.setImageWith(asd)
            
        }
    }

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
