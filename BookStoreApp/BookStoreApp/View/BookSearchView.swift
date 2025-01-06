//
//  BookSearchView.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//
import UIKit
import SnapKit

class BookSearchView: UIView {
    let searchBar = UISearchBar()
    let recentBooksLabel = UILabel()
    let recentBooksCollectionView: UICollectionView
    let searchResultsLabel = UILabel()
    let searchResultsCollectionView: UICollectionView

    override init(frame: CGRect) {
      
        let recentBooksLayout = UICollectionViewFlowLayout()
        recentBooksLayout.scrollDirection = .horizontal
        recentBooksLayout.minimumLineSpacing = 10

        
        let searchResultsLayout = UICollectionViewFlowLayout()
        searchResultsLayout.scrollDirection = .vertical
        searchResultsLayout.minimumLineSpacing = 10

        recentBooksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: recentBooksLayout)
        searchResultsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: searchResultsLayout)
        
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white

        
        searchBar.placeholder = "책을 검색해주세요"
        searchBar.searchBarStyle = .minimal
        addSubview(searchBar)

        
        recentBooksLabel.text = "최근 본 책"
        recentBooksLabel.font = UIFont.boldSystemFont(ofSize: 28)
        recentBooksLabel.textColor = .black
        addSubview(recentBooksLabel)

      
        searchResultsLabel.text = "검색 결과"
        searchResultsLabel.font = UIFont.boldSystemFont(ofSize: 28)
        searchResultsLabel.textColor = .black
        addSubview(searchResultsLabel)

       
        recentBooksCollectionView.backgroundColor = .clear
        addSubview(recentBooksCollectionView)

     
        searchResultsCollectionView.backgroundColor = .clear
        addSubview(searchResultsCollectionView)

       
    }

    private func setupLayout() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }

        recentBooksLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        recentBooksCollectionView.snp.makeConstraints {
            $0.top.equalTo(recentBooksLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150) 
        }

        searchResultsLabel.snp.makeConstraints {
            $0.top.equalTo(recentBooksCollectionView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }

        searchResultsCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchResultsLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

    }
}
