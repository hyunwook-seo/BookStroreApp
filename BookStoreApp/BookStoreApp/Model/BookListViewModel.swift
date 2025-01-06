//
//  BookListViewModel.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/6/25.
//

import Foundation

class BookListViewModel {
    private var books: [Book] = []
    var onDataUpdate: (() -> Void)?

    func fetchBooks() {
        books = BookListManager.shared.fetchBooks() 
        onDataUpdate?()
    }

    func addBook(_ book: Book) {
        BookListManager.shared.addBook(book)
        fetchBooks()
    }

    func deleteBook(at index: Int) {
        let book = books[index]
        BookListManager.shared.deleteBook(book)
        fetchBooks()
    }

    func deleteAllBooks() {
        BookListManager.shared.deleteAllBooks()
        fetchBooks()
    }

    var numberOfBooks: Int {
        return books.count
    }

    func book(at index: Int) -> Book {
        return books[index]
    }
}
