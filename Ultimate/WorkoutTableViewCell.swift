//
//  WorkoutTableViewCell.swift
//  Ultimate
//
//  Created by Kenta Kawaguchi on 1/7/17.
//  Copyright © 2017 Kenta Kawaguchi. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    var workout: Workout! {
        didSet {
            nameLabel.text = workout.name
            typeLabel.text = workout.type
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
