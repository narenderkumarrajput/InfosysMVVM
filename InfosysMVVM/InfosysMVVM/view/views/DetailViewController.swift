//
//  DetailViewController.swift
//  InfosysMVVM
//
//  Created by Narender Kumar on 12/24/19.
//  Copyright © 2019 Narender Kumar. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var detailVM: CountryInfoTableViewCellViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = detailVM?.title ?? ""
        descriptionTextView.text = detailVM?.description ?? ""
        if let imgUrl = detailVM?.imageHref {
            let url = URL(string: imgUrl)
            if url != nil {
                SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground, context: nil, progress: nil) { (image, data, erroe, SDImageCacheType, isFinshed, uRL) in
                    if image != nil {
                        self.imageView.image = image
                    }
                }
            } else {
                print("Image Url issue : \(imgUrl)")
            }
        }
    }

}
