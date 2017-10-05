//
//  menuViewController.swift
//  Twitter_login_demo
//
//  Created by Justin Sumner on 10/4/17.
//  Copyright © 2017 Justin Sumner. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var tweetsViewController: UIViewController!
    private var profileViewController: ProfileViewController!
    private var mentionsViewController: MentionsViewController!
    
    var viewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        self.tableView.reloadData()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetsViewController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        
        viewControllers.append(tweetsViewController)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 33
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
        let titles = ["Tweets", "asd", "qwe"]
        //cell.menuCellLabel.text = titles[indexPath.row]
        return cell
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
