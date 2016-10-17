//
//  DetailViewController.swift
//  Flicks
//
//  Created by Prachie Banthia on 10/16/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var titleText = ""
    var descText = ""
    var img: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentWidth = scrollView.bounds.width
        let contentHeight = textView.frame.height + textView.frame.origin.y
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        let subviewHeight = textView.frame.height
        var currentViewOffset = CGFloat(150);
        scrollView.addSubview(textView)
        
        while currentViewOffset < contentHeight {
            currentViewOffset += subviewHeight
        }
        
        movieTitle.text = titleText
        movieDesc.text = descText
        imgView.image = img
        movieDesc.sizeToFit()
        movieTitle.sizeToFit()

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
