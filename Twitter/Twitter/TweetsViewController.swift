//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Prachie Banthia on 11/1/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    var tweets = [Tweet]()
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

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

        
        print("the tweets")
        print(tweets)
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        cell.desc.text = tweet.texto
        if let profileImageUrl = tweet.user?.profileUrl {
            cell.profileImg?.setImageWith(profileImageUrl)
            cell.profileImg?.layer.cornerRadius = 8.0
            cell.profileImg?.clipsToBounds = true
        } else {
            cell.profileImg?.image = nil
        }

        if let screenname = tweet.user?.screenname {
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
    
    func refreshControlAction(refreshControl: UIRefreshControl?) {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            refreshControl?.endRefreshing()
            self.tweets = tweets
            self.tableView.reloadData()
            
        }) { (error: Error?) in
            refreshControl?.endRefreshing()
            print("Error fetching tweets \(error?.localizedDescription)")
        }

    }
    
    // passes tweet data to the detail view
    override func prepare(for segue: UIStoryboardSegue, sender s: Any?) {
        if (segue.identifier == "ProfileSegue"){
            print("in the prof segue")
            let destinationVC = segue.destination as! ProfileViewController
            let s1 = s as! UITapGestureRecognizer
            let swipeLocation = s1.location(in: self.tableView)
            if let swipedIndexPath = tableView.indexPathForRow(at: swipeLocation) {
                if let swipedCell = self.tableView.cellForRow(at: swipedIndexPath) as? TweetCell {
                    let tweet = tweets[swipedIndexPath.row]
                    destinationVC.numTweets = tweet.user?.numTweets ?? 0
                    destinationVC.numFollowers = tweet.user?.numFollowers ?? 0
                    destinationVC.backgroundUrl = tweet.user?.backgroundUrl
                    destinationVC.numFollowing = tweet.user?.numFollowing ?? 0
                }
            }
        } else if(segue.identifier == "DetailSegue"){
            print("in the detail segue")
            let destinationVC = segue.destination as! DetailViewController
            if let index = tableView.indexPath(for: s as! TweetCell){
                if let cell = tableView.cellForRow(at: index) as? TweetCell {
                    destinationVC.descT = cell.desc.text ?? ""
                    destinationVC.timeT = cell.timestamp.text ?? ""
                    destinationVC.usernameT = cell.username.text ?? ""
                }
            }
        } else {
            super.prepare(for: segue, sender: s)
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
