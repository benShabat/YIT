//
//  ImageEntity.swift
//  YIT
//
//  Created by Ben Shabat on 18/08/2021.
//

import Foundation

struct HitsEntity:Decodable {
    var hits: [ImageEntity]
}

struct ImageEntity:Decodable {
    var previewURL: String
    var previewWidth: Int
    var previewHeight: Int
    var largeImageURL: String
}
