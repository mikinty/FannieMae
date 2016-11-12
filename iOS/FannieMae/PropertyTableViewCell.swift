//
//  PropertyTableViewCell.swift
//  FannieMae
//
//  Created by Arunjot Singh on 11/12/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {

    @IBOutlet var houseImage: UIImageView!
    @IBOutlet var houseName: UILabel!
    @IBOutlet var houseAddress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
