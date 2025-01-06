//
//  BookResponse.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/5/25.
//



import Foundation

struct BookResponse: Decodable {
    let title: String
    let authors: [String]
    let price: Int?
    let description: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case title
        case authors
        case price
        case description = "contents"
        case thumbnail
    }
}
