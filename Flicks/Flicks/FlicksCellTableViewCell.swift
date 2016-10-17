//
//  FlicksCellTableViewCell.swift
//  Flicks
//
//  Created by Prachie Banthia on 10/16/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class FlicksCellTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
