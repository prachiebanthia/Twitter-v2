//
//  MenuViewController.swift
//  Twitter
//
//  Created by Prachie Banthia on 11/6/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    private var tweetsViewController:UIViewController!
    private var profileViewController:ProfileViewController!
    private var mentionsViewController:ProfileViewController!
    
    var viewControllers:[UIViewController] = []
    let titles = ["Feed", "Profile", "Mentions"]
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        initViewControllers()
    }
    
    func initViewControllers() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        tweetsViewController = storyboard.instantiateViewController(withIdentifier: "TweetsController")
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileViewController
        mentionsViewController = profileViewController
        
        if let backImageUrl = User.currentUser?.backgroundUrl {
            print("backimg")
            print(backImageUrl)
            profileViewController.backgroundUrl = backImageUrl
        } 
        
        viewControllers.append(tweetsViewController)
        viewControllers.append(profileViewController)
        viewControllers.append(mentionsViewController)
        
        hamburgerViewController.contentViewController = tweetsViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.menuItem.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
