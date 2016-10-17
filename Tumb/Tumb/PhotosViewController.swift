//
//  ViewController.swift
//  Tumb
//
//  Created by Prachie Banthia on 10/15/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit
import AFNetworking


class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var thePosts = [NSDictionary]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
                    self.thePosts = responseDictionary.value(forKeyPath: "response.posts") as! [NSDictionary]
                    self.tableView.reloadData()
                    
                }
            }
            
        });
        task.resume()
        tableView.rowHeight = 320;
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.prachie.DemoPrototypeCell") as! DemoPrototypeCell
        
        let post = self.thePosts[indexPath.row] as NSDictionary
        let photos = post.value(forKeyPath: "photos")
        if (nil != photos) {
            let photosArray = photos as! NSArray
            let photo = photosArray[0] as! NSDictionary
            let url = URL(string: (photo.value(forKeyPath: "original_size.url") as! String))
            cell.iView.setImageWith(url!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("thecount")
        print (thePosts.count)
        return thePosts.count
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

