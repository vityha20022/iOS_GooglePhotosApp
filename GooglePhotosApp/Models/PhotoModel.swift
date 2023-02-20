//
//  PhotoModel.swift
//  GooglePhotosApp
//
//  Created by Виктор Борисовский on 18.02.2023.
//

import Foundation

struct GooglePhotosSearchResult: Decodable {
    // swiftlint: disable identifier_name
    let images_results: [GooglePhoto]
    // swiftlint: enable identifier_name
}

struct GooglePhoto: Decodable {
    let original: String
    // swiftlint: disable identifier_name
    let original_width: Int
    let original_height: Int
    // swiftlint: enable identifier_name
    let link: String
}
