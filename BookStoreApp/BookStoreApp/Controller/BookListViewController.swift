//
//  BookListViewController.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//


import UIKit

class BookListViewController: UIViewController {
    let bookListView = BookListView()
    private var books: [Book] = []

    override func loadView() {
        view = bookListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "담은 책 리스트"
        setupCollectionView()
        setupActions()
        fetchBooks()
    }

    private func setupCollectionView() {
        bookListView.collectionView.delegate = self
        bookListView.collectionView.dataSource = self
        bookListView.collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCell")
    }

    private func setupActions() {
        bookListView.clearAllButton.addTarget(self, action: #selector(clearAllBooks), for: .touchUpInside)
        bookListView.addBookButton.addTarget(self, action: #selector(addBookTapped), for: .touchUpInside)
    }

    private func fetchBooks() {
        books = BookListManager.shared.fetchBooks()
        bookListView.collectionView.reloadData()
    }

    @objc private func clearAllBooks() {
        BookListManager.shared.deleteAllBooks()
        fetchBooks()
    }

    @objc private func addBookTapped() {
//        let newBook = Book(
//            title: "새 책",
//            author: "저자",
//            price: "10,000원",
//            description: "책 설명",
//            imageUrl: "https://via.placeholder.com/150"
//        )
//        BookListManager.shared.addBook(newBook)
//        fetchBooks()
    }

    // 새로 추가된 reloadData 메서드
    func reloadData() {
        fetchBooks()
    }
}

extension BookListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCollectionViewCell
        let book = books[indexPath.row]
        cell.configure(with: book)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 40
        return CGSize(width: width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
