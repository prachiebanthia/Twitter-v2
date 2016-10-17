//
//  ViewController.swift
//  Flicks
//
//  Created by Prachie Banthia on 10/16/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var responseData: NSArray? = nil
    var moviesArray: [MovieData] = []
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadData(refreshControl: nil)
    }
    
    func loadData(refreshControl: UIRefreshControl?){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    if let resultsArray = responseDictionary.value(forKeyPath: "results") as? NSArray {
                        self.responseData = resultsArray
                        self.moviesArray = self.getMoviesArray()
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.tableView.reloadData()
                        // Tell the refreshControl to stop spinning
                        refreshControl?.endRefreshing()
                    }
                }
            } else{
                self.errorView.isHidden = false
            }
        });
        task.resume()
    }
    
    // fills in the data about the movie in the dequeued cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.prachie.FlicksCell", for: indexPath) as! FlicksCellTableViewCell
        
        if moviesArray[indexPath.row].poster_path != nil{
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(moviesArray[indexPath.row].poster_path!)")
            cell.movieImg.setImageWith(url!)
        }
        cell.movieTitle.text = moviesArray[indexPath.row].original_title
        cell.movieDesc.text = moviesArray[indexPath.row].overview
        cell.movieTitle.sizeToFit()
        cell.movieDesc.sizeToFit()

        return cell
    }
    
    // returns the number of movies, required
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }

    // returns the array of movies with relevant movie information
    func getMoviesArray() -> [MovieData] {
        var moviesArray: [MovieData] = []
        for i in 0...(self.responseData!.count - 1){
            let movie = MovieData(movie: responseData?[i] as! NSDictionary)
            moviesArray.append(movie)
        }
        return moviesArray
    }
    
    // passes movie data to the detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        if let index = tableView.indexPath(for: sender as! FlicksCellTableViewCell){
            if let cell = tableView.cellForRow(at: index) as? FlicksCellTableViewCell {
                destinationVC.img = cell.movieImg.image
                destinationVC.descText = cell.movieDesc.text!
                destinationVC.titleText = cell.movieTitle.text!
            }
        }
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        loadData(refreshControl: refreshControl)
    }
    
    // method to deselect a row once it's been chosen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

