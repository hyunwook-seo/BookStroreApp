//
//  BookSearchViewController.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//
import UIKit
import SnapKit

class BookSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    private let bookSearchView = BookSearchView()
    private let viewModel = BookSearchViewModel()

    override func loadView() {
        view = bookSearchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "검색 탭"
        setupCollectionViews()
        setupSearchBar()
        bindViewModel()
    }

    private func setupCollectionViews() {
        // 최근 본 책 CollectionView 설정
        bookSearchView.recentBooksCollectionView.delegate = self
        bookSearchView.recentBooksCollectionView.dataSource = self
        bookSearchView.recentBooksCollectionView.register(RecentBookCollectionViewCell.self, forCellWithReuseIdentifier: "RecentBookCell")

        // 검색 결과 CollectionView 설정
        bookSearchView.searchResultsCollectionView.delegate = self
        bookSearchView.searchResultsCollectionView.dataSource = self
        bookSearchView.searchResultsCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCell")
    }

    private func setupSearchBar() {
        bookSearchView.searchBar.delegate = self
    }

    private func bindViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.bookSearchView.searchResultsCollectionView.reloadData()
            }
        }

        viewModel.onRecentBooksUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.bookSearchView.recentBooksCollectionView.reloadData()
            }
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return }
        viewModel.fetchBooks(query: searchText)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bookSearchView.recentBooksCollectionView {
            return viewModel.numberOfRecentBooks()
        } else {
            return viewModel.numberOfBooks()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bookSearchView.recentBooksCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentBookCell", for: indexPath) as! RecentBookCollectionViewCell
            let book = viewModel.recentBook(at: indexPath.row)
            cell.configure(with: book)
            cell.layer.cornerRadius = cell.bounds.width / 2
            cell.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath) as! BookCollectionViewCell
            let book = viewModel.book(at: indexPath.row)
            cell.configure(with: book)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook: Book
        if collectionView == bookSearchView.recentBooksCollectionView {
            selectedBook = viewModel.recentBook(at: indexPath.row)
        } else {
            selectedBook = viewModel.book(at: indexPath.row)
        }

        viewModel.addRecentBook(selectedBook)

        let detailVC = BookDetailViewController()
        detailVC.book = selectedBook
        detailVC.modalPresentationStyle = .automatic
        present(detailVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bookSearchView.recentBooksCollectionView {
            return CGSize(width: 80, height: 80)
        } else {
            return CGSize(width: collectionView.bounds.width - 40, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
