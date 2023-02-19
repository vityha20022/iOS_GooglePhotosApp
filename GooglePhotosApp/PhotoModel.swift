//
//  PhotoModel.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 18.02.2023.
//

import Foundation

struct GooglePhotosSearchResult: Decodable {
    let images_results: [GooglePhoto]
}

struct GooglePhoto: Decodable {
    let original: String
    let original_width: Int
    let original_height: Int
    let link: String
}
