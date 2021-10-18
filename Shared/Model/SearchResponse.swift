//
//  Item.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/15.
//

import Foundation

struct Documents: Codable {
    let collection: String
    let thumbnail_url: String
    let image_url: String
    let width: Int
    let height: Int
    let display_sitename: String
    let doc_url: String
    let datetime: String
}

struct MetaData: Codable {
    let total_count: Int
    let pageable_count: Int
    let is_end: Bool
}

struct SearchResponse: Codable {
    var meta: MetaData
    var documents: [Documents]
}
