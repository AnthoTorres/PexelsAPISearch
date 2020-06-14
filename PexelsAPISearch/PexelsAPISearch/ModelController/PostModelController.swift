//
//  PostModelController.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/13/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit

/// PostModelController is suppose to decide if a post is already saved or needs to be retrived from the api. (even though i did not get caching to work...)
class PostModelController {
    
    static let shared = PostModelController()

    var service = APIService.shared

    var fetchingMore = false

    var responsePhotos = [Photo]()
    var postArray = [Post]()
    
    /// This function will get photos from the api or from the device.
    func getPhotos(search: String?, completion: @escaping()->()) {
        self.fetchingMore = true // sets a limit so we dont try to get photos if we are already in the middle of doing it
        
        var tempPostArray = [Post]()
        let dispatchGroup = DispatchGroup()
        
        service.fetchPhotos(search: search ?? "red") { (apiResp) in
            guard let response = apiResp else {
                errMessage.showError(with: "Faild to received the response.", errorType: .error)
                print("Faild to received the response.")
                completion()
                return
            }
            
            self.responsePhotos.append(contentsOf: response.photos)
            
            // I get 2 responses because I want 30 photos and each request gives me 15
            self.service.fetchPhotos(search: search ?? "red") { (apiResp2) in
                if let response2 = apiResp2 {
                    self.responsePhotos.append(contentsOf: response2.photos)
                }
                
                DispatchQueue.main.async {
                    for photo in self.responsePhotos {
                        
                        if !self.postArray.contains(where: { $0.id == photo.id}) {
                            dispatchGroup.enter() // this makes sure we dont move on without finishing our request for photos
                            self.service.getImage(with: photo.id) { (respImage) in
                                if let image = respImage {
                                    tempPostArray.append(Post(id: photo.id, image: image, lastSearch: search ?? "red", author: photo.photographer))
                                    dispatchGroup.leave()
                                }
                            }
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        self.postArray = tempPostArray
                        self.fetchingMore = false
                        completion()
                    }
                }
            }
        }
    }
    
    func refresh() {
        self.service.nextPage = nil
        self.responsePhotos.removeAll()
        self.postArray.removeAll()
    }
}
