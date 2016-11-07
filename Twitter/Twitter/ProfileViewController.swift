//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Prachie Banthia on 11/5/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     var tweets = [Tweet]()
    
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var theImage: UIImageView!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    var numTweets = 0
    var numFollowers = 0
    var numFollowing = 0
    var backgroundUrl: URL?

    @IBOutlet weak var tableView: UITableView!
    
    var descT = ""
    var usernameT = ""
    var timeT = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numTweetsLabel.text = String(numTweets)
        numFollowersLabel.text = String(numFollowers)
        numFollowingLabel.text = String(numFollowing)
        theImage.setImageWith(backgroundUrl!)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }) { (error: Error?) in
            print("Error fetching tweets \(error?.localizedDescription)")
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTweetsCell", for: indexPath) as! MyTweetsCell
        let tweet = tweets[indexPath.row]
        cell.desc.text = tweet.texto
        /* if let profileImageUrl = tweet.user?.profileUrl {
            cell.profileImg.setImageWith(profileImageUrl)
            cell.profileImg.layer.cornerRadius = 8.0
            cell.profileImg.clipsToBounds = true
        } else {
            cell.profileImg.image = nil
        } */
        
        if let screenname = tweet.user?.screenname {
            print("screenname")
            print(screenname)
            cell.username.text = "@\(screenname)"
        } else {
            cell.username.text = nil
        }
        
        cell.timestamp.text = tweet.timeSinceCreated
        
        return cell
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
