//
//  ImageCollectionViewCell.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/13/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit


class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    public func configure(with image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.contentMode = .center
            self.imageView.image = image
            self.imageView.curve()
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    
}
