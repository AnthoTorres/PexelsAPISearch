//
//  APIResponse.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/12/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import Foundation

struct APIResponse: Decodable {
    var Response: Response
}

/**
 The Photo object is a JSON formatted version of a Pexels photo. The Photo API endpoints respond with the photo data formatted in this shape.
 
 "total_results": 10000,
 "page": 1,
 "per_page": 15,
 "photos": [{ Photo }]
 */

struct Response: Decodable {
    var total_results: Int
    var page: Int
    var per_page: Int
    var photos: [Photo]
    var next_page: String
}

/**
 
 This is the Photo Object
 {
   "id": 2014422,
   "width": 3024,
   "height": 3024,
   "url": "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
   "photographer": "Joey Farina",
   "photographer_url": "https://www.pexels.com/@joey",
   "photographer_id": 680589,
   "src": {  }
 }
 */
struct Photo: Decodable {
    
    var id: Int
    var width: Int
    var height: Int
    var url: String
    var photographer: String
    var photographer_url: String
    var photographer_id: Int
    
}

struct Image: Decodable {
    var src: Source
}

struct Source: Decodable {
    var medium: String
}
