//
//  BookSearchViewModel.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/5/25.
//

import Foundation

class BookSearchViewModel {
    private let apiKey = "e2c35784d566991098f0a23a25ac589a"
    private var books: [Book] = []
    private var recentBooks: [Book] = []

    var onDataUpdate: (() -> Void)?
    var onRecentBooksUpdate: (() -> Void)?

    func fetchBooks(query: String) {
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=\(query)") else { return }

        var request = URLRequest(url: url)
        request.addValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching books: \(error)")
                return
            }

            guard let data = data else { return }
            
            print("Received data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")

            do {
                let responseWrapper = try JSONDecoder().decode(BookResponseWrapper.self, from: data)
                self.books = responseWrapper.documents.map { Book(from: $0) }
                self.onDataUpdate?()
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }

    func numberOfBooks() -> Int {
        return books.count
    }

    func book(at index: Int) -> Book {
        return books[index]
    }


    func numberOfRecentBooks() -> Int {
        return recentBooks.count
    }

    func recentBook(at index: Int) -> Book {
        return recentBooks[index]
    }

    func addRecentBook(_ book: Book) {
        // 중복 제거
        if let existingIndex = recentBooks.firstIndex(where: { $0.title == book.title }) {
            recentBooks.remove(at: existingIndex)
        }

        // 가장 최근에 본 책을 배열의 맨 앞에 추가
        recentBooks.insert(book, at: 0)

        // 최대 10개까지만 유지
        if recentBooks.count > 10 {
            recentBooks.removeLast()
        }

        // 업데이트 콜백 호출
        onRecentBooksUpdate?()
    }

    func clearRecentBooks() {
        recentBooks.removeAll()
        onRecentBooksUpdate?()
    }
}
