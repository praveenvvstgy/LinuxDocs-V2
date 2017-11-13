//
//  DocTableViewCell.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/11/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit

class DocTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00).cgColor
        containerView.layer.shadowRadius = 12
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowOffset = CGSize.zero
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
