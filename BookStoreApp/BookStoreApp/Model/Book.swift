//
//  Book.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//

import Foundation

struct Book {
    let title: String
    let author: String
    let price: String
    let description: String
    let imageUrl: String
}

extension Book {
    init(from response: BookResponse) {
        
        print("Response title: \(response.title)")
        print("Response authors: \(response.authors)")
        print("Response price: \(String(describing: response.price))")
        
        self.title = response.title
        self.author = response.authors.joined(separator: ", ") 
        self.price = response.price.map { "\($0)원" } ?? "가격 없음"
        self.description = response.description.isEmpty ? "설명 없음" : response.description
        self.imageUrl = response.thumbnail.isEmpty ? "" : response.thumbnail
    }
}
