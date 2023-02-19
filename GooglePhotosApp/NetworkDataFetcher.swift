//
//  NetworkDataFetcher.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 19.02.2023.
//

import Foundation
import Alamofire

class NetworkDataFetcher {
    let apiKey = "59b32ef71ea1ebb26d3bd1c4ecb19815714634ef306871d1b52420a793077af2"
    
    func fetchPhotos(searchTerm: String, completion: @escaping (GooglePhotosSearchResult?, Error?) -> Void) {
        let parameters = [
            "q": searchTerm,
            "tbm": "isch",
            "ijn": "0",
            "api_key": apiKey
        ]
        
        AF.request("https://serpapi.com/search", parameters: parameters)
            .validate()
            .responseDecodable(of: GooglePhotosSearchResult.self) { response in
                guard let photos = response.value else {
                    completion(nil, response.error)
                    return
                }
                
                completion(photos, nil)
            }
    }
}
