//
//  VideoCell.swift
//  Project_Final
//
//  Created by Varun Yadav on 10/31/17.
//  Copyright © 2017 Vineeth Xavier. All rights reserved.
//

import UIKit
import CoreMotion

internal class VideoCell: BaseRoundedCardCell {
    
    /// Image View
    @IBOutlet  weak var imageView: UIImageView!
    // Title for the Video
    @IBOutlet weak var TitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 14.0
    }

}
