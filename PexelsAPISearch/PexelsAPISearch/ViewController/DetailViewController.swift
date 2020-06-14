//
//  DetailViewController.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/13/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    var post: Post! {
        didSet {
            setup()
        }
    }
    
    func setup() {
        DispatchQueue.main.async {
            self.imageView.image = self.post.image
            self.authorLabel.text = self.post.author
        }
    }
}
