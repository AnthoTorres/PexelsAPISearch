//
//  Post.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/13/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit
import AVFoundation

/// This class is to store an image, id, and author so that we can view details later after tapping on the image
class Post {
    var id: Int
    var image: UIImage
    var video: AVPlayer? // Maybe for later?
    var lastSearch: String
    var author: String
    
    init(id: Int, image: UIImage, lastSearch: String, author: String) {
        self.id = id
        self.image = image
        self.lastSearch = lastSearch
        self.author = author
    }
}
