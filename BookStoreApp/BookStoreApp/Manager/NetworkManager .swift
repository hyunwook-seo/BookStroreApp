//
//  NetworkManager .swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/5/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://dapi.kakao.com/v3/search/book"
    private let apiKey = "KakaoAK e2c35784d566991098f0a23a25ac589a"
    
    private init() {}
    
    func fetchBooks(query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)?query=\(encodedQuery)") else {
            return completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let wrapper = try JSONDecoder().decode(BookResponseWrapper.self, from: data)
                let books = wrapper.documents.map { Book(from: $0) }
                completion(.success(books))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
