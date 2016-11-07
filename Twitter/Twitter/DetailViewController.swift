//
//  DetailViewController.swift
//  Twitter
//
//  Created by Prachie Banthia on 11/1/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweets = [Tweet]()

    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    var descT = ""
    var usernameT = ""
    var timeT = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desc.text = descT
        username.text = usernameT
        timestamp.text = timeT
        // Do any additional setup after loading the view.
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
