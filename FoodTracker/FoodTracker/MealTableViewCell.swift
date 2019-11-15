//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by José Pereira on 11/8/19.
//  Copyright © 2019 José Pereira. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
