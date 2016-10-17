//
//  PhotoDetailsViewController.swift
//  tumtum
//
//  Created by Prachie Banthia on 10/16/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var temp: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = temp
        
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
