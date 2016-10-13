//
//  PhotoViewCell.swift
//  Instagram
//
//  Created by Ken Lâm on 10/13/16.
//  Copyright © 2016 Ken Lam. All rights reserved.
//

import UIKit

class PhotoViewCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
