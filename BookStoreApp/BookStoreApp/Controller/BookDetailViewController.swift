//
//  BookDetailViewController.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//
import UIKit

class BookDetailViewController: UIViewController {
    let bookDetailView = BookDetailView()
    var book: Book?

    override func loadView() {
        view = bookDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "책 상세"
        setupBookDetails()
        setupActions()
    }

    private func setupBookDetails() {
        guard let book = book else { return }
        bookDetailView.titleLabel.text = book.title
        bookDetailView.authorLabel.text = book.author
        bookDetailView.priceLabel.text = book.price
        bookDetailView.descriptionLabel.text = book.description

        if let url = URL(string: book.imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.bookDetailView.bookImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

    private func setupActions() {
        bookDetailView.closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        bookDetailView.addButton.addTarget(self, action: #selector(addBookToList), for: .touchUpInside)
    }

    @objc private func closeModal() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func addBookToList() {
        guard let book = book else { return }
        BookListManager.shared.addBook(book)
        
        if let tabBarController = presentingViewController as? UITabBarController,
           let navController = tabBarController.viewControllers?[1] as? UINavigationController,
           let bookListVC = navController.viewControllers.first as? BookListViewController {
            bookListVC.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}
