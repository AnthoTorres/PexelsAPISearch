//
//  ViewController.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/12/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit

class PhotoBrowserCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var service = APIService.shared
    
    // TODO: find a better name
    var imagesArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.fetchPhotos { (apiResp) in
            
            let dispatchGroup = DispatchGroup()
            
            guard let response = apiResp else {
                print("Faild to received the response.")
                return
            }
//            print("\(response.photos)")
            DispatchQueue.main.async {
            for photo in response.photos {
                dispatchGroup.enter()
                self.service.getImage(with: photo.id) { (image) in
                        self.imagesArray.append(image ?? UIImage())
                    dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    self.collectionView.reloadData()
                    print("\(self.imagesArray.count)")
                }
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        let image = UIImageView(image: imagesArray[indexPath.row])
        image.contentMode = .scaleAspectFit
        DispatchQueue.main.async {
            cell.addSubview(image)
        }
        //cell.backgroundColor = .red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let numberOfSets = CGFloat(self.imagesArray.count)

        let width =  (collectionView.frame.size.width / 3) - 10

        let height = collectionView.frame.size.height / 3

        return CGSize(width: width, height: height)
    }
    
}
