//
//  PhotoViewCell.swift
//  Instagram-Parse
//
//  Created by Senyang Zhuang on 3/1/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class PhotoViewCell: UITableViewCell {
    
 
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
