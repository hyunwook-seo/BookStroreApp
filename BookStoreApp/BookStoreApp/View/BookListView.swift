//
//  BookListView.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//

import UIKit
import SnapKit

class BookListView: UIView {
    let titleLabel = UILabel()
    let collectionView: UICollectionView
    let clearAllButton = UIButton(type: .system)
    let addBookButton = UIButton(type: .system)

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        
        // Title Label
        titleLabel.text = "담은 책"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)

        // Clear All Button
        clearAllButton.setTitle("전체 삭제", for: .normal)
        clearAllButton.setTitleColor(.red, for: .normal)
        clearAllButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        addSubview(clearAllButton)

        // Add Book Button
        addBookButton.setTitle("추가", for: .normal)
        addBookButton.setTitleColor(.systemGreen, for: .normal)
        addBookButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        addSubview(addBookButton)

        // CollectionView
        collectionView.backgroundColor = .white
        addSubview(collectionView)

        // Custom Tab Bar View 추가
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.centerX.equalToSuperview()
        }

        clearAllButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(40)
        }

        addBookButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.trailing.equalToSuperview().inset(40)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(clearAllButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
