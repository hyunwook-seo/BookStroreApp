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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchBooks()
        bookListView.collectionView.reloadData()
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
        bookListView.collectionView.reloadData()
    }

    @objc private func addBookTapped() {
        let newBook = Book(
            title: "새 책",
            author: "저자",
            price: "10,000원",
            description: "책 설명",
            imageUrl: "https://via.placeholder.com/150"
        )
        BookListManager.shared.addBook(newBook)
        fetchBooks()
        bookListView.collectionView.reloadData()
    }

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
    func collectionView(_ collectionView: UICollectionView, trailingSwipeActionsConfigurationForItemAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let bookToDelete = self.books[indexPath.row]

            BookListManager.shared.deleteBook(bookToDelete)

            self.books.remove(at: indexPath.row)

            collectionView.deleteItems(at: [indexPath])

            completionHandler(true)
        }

        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
