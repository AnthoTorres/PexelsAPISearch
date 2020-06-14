//
//  APIService.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/12/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit

class APIService {
    
    static let shared = APIService()
    
    /// This will keep track of the different kinds of searches we can do...
    enum SearchType {
        case search
        case photo
        
        var rawValue: String {
            switch self {
            case .search:
                return "search?query="
            case .photo:
                return "photos/"
            }
        }
    }
    
    // MARK: - Properties that help with the API
    
    var baseRawURL: String = "https://api.pexels.com/v1/"
    var httpHeader: [String:String] = ["Authorization": "563492ad6f917000010000015b15de255f064471835f9257966b3c75"]
    var nextPage: String?
    
    /// This function will either get the next page of photos or it will get a new search
    func fetchPhotos(search: String = "red", completion:@escaping(Response?) -> Void) {
        // If there is no nextPage then we will use what ever was searched
        let pageURL: String = (nextPage != nil) ? nextPage! : baseRawURL + SearchType.search.rawValue + search
        
        guard let baseURL = URL(string: pageURL)
            else {
                completion(nil)
                return
        }
        
        // This is to set up permisson info to go along with the request
        let config = URLSessionConfiguration.default
        
        config.httpShouldUsePipelining = true
        config.httpAdditionalHeaders = httpHeader
        
        let session = URLSession(configuration: config)
        
        session.dataTask(with: baseURL) { (data, response, error) in
            if error != nil {
                completion(nil)
            }
            if let data = data {
                do {
                    let apiResp = try JSONDecoder().decode(Response.self, from: data)
                    self.nextPage = apiResp.next_page
                    completion(apiResp)
                }
                catch let jsonError {
                    errMessage.showError(with: "STATS:" + jsonError.localizedDescription, errorType: .error)
                    print("STATS:", jsonError.localizedDescription)
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func getImage(with id: Int? = nil, url: String? = nil, completion: @escaping(UIImage?) ->Void) {
        if (id == nil && url == nil) {
            errMessage.showError(with: "Both id and url are nil." , errorType: .error)
            print("Both id and url are nil. This function wont work without one or the other.")
            completion(nil)
            return
        }
        
        let idWasProvided: Bool = (id != nil)
        
        // NOTE: My first time writing a turnary operator
        let urlString: String = idWasProvided ? baseRawURL + SearchType.photo.rawValue + "\(id!)": url!
        
        guard let baseURL = URL(string: urlString)
            else {
                completion(nil)
                return
        }
        
        let config = URLSessionConfiguration.default
        
        config.httpShouldUsePipelining = true
        config.httpAdditionalHeaders = httpHeader
        
        let session = URLSession(configuration: config)
        
        DispatchQueue.main.async {
            session.dataTask(with: baseURL) { (data, response, error) in
                if error != nil {
                    completion(nil)
                }
                
                if let data = data {
                    
                    if idWasProvided {
                        // NOTE: In order to check what I'm gett back (for debugging)
                        /* let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Any */
                        do {
                            let photo = try JSONDecoder().decode(Image.self, from: data)
                            self.getImage(url: photo.src.medium) { (image) in
                                completion(image)
                            }
                            
                        }
                        catch let jsonError {
                            errMessage.showError(with: "STATS:" + jsonError.localizedDescription, errorType: .error)
                            print("STATS:", jsonError.localizedDescription)
                            completion(nil)
                        }
                    }
                    else {
                        guard let image = UIImage(data: data) else { return completion(nil) }
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}

