//
//  MyTweetsCell.swift
//  Twitter
//
//  Created by Prachie Banthia on 11/6/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class MyTweetsCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var desc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
