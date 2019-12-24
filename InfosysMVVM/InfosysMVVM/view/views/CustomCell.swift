//
//  CustomCell.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/24/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import UIKit
import SDWebImage

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(_ countryInfoVM: CountryInfoTableViewCellViewModel) {
        self.titleLbl.text = countryInfoVM.title
        self.descLbl.text = countryInfoVM.description
        if let _ = countryInfoVM.imageHref {
            imageViewWidth.constant = 80.0
            let url = URL(string: countryInfoVM.imageHref!)
            SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground, context: nil, progress: nil) { (image, data, erroe, SDImageCacheType, isFinshed, uRL) in
                if image != nil {
                    self.imgView.image = image
                }
            }
        } else {
            imageViewWidth.constant = 0.0
        }
    }
    
    
}
