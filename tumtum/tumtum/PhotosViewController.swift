
import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        */
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humans.tumblr.com/posts/photo?api_key=\(apiKey)")
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
                    self.posts = responseDictionary.value(forKeyPath: "response.posts") as! [NSDictionary]
                    self.tableView.reloadData()
                }
            }
        });
        task.resume()
        
      //  tableView.rowHeight = 320
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.posts.count
    }
    /*
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let apiKey = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
        let url = URL(string:"https://api.tumblr.com/v2/blog/humans.tumblr.com/posts/photo?api_key=\(apiKey)")
        
        
        let request = URLRequest(url: url!)
        let task : URLSessionDataTask = session.dataTask(with: request,
                                                         
                                                         completionHandler: { (data, response, error) in
                                                            
                                                            // ... Use the new data to update the data source ...
                                                            
                                                            // Reload the tableView now that there is new data
                                                            self.tableView.reloadData()
                                                            
                                                            // Tell the refreshControl to stop spinning
                                                            refreshControl.endRefreshing()
        });
        task.resume()
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // set the avatar
        profileView.setImageWith(NSURL(string:"https://api.tumblr.com/v2/blog/humans.tumblr.com/avatar")! as URL)
        headerView.addSubview(profileView)
        
        // Add a UILabel for the date here
        // Use the section number to get the right URL
        let label = "ADD DATE HERE"
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as! DemoPrototypeCell,
        postDictionary = self.posts[indexPath.row] as NSDictionary
        
        // TODO
        let photos = postDictionary.value(forKeyPath: "photos")
        if (nil != photos) {
            let photosArray = photos as! NSArray
            let photo = photosArray[0] as! NSDictionary
            let url = URL(string: (photo.value(forKeyPath: "original_size.url") as! String))
            cell.iView.setImageWith(url!)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        let cell = tableView(tableView, cellForRowAt: indexPath!) as! DemoPrototypeCell
        vc.temp = cell.iView.image
    }
}
