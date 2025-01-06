//
//  BookResponseWrapper.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/5/25.
//

import Foundation

struct BookResponseWrapper: Decodable {
    let documents: [BookResponse]
    let meta: Meta

    struct Meta: Decodable {
        let is_end: Bool
        let pageable_count: Int
        let total_count: Int
    }
}
