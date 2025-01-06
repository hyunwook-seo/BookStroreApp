//
//  BookDetailView.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//

import UIKit
import SnapKit

class BookDetailView: UIView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let bookImageView = UIImageView()
    let priceLabel = UILabel()
    let descriptionLabel = UILabel()
    let closeButton = UIButton(type: .system)
    let addButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white

        // 스크롤 뷰 추가
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // 스크롤 뷰 속성설정
        scrollView.isScrollEnabled = true
        scrollView.contentInset = .zero
        scrollView.contentOffset = .zero
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true


        // Title Label
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)

        // Author Label
        authorLabel.font = .systemFont(ofSize: 16)
        authorLabel.textColor = .darkGray
        authorLabel.textAlignment = .center
        contentView.addSubview(authorLabel)

        // Book Image View
        bookImageView.contentMode = .scaleAspectFit
        contentView.addSubview(bookImageView)

        // Price Label
        priceLabel.font = .systemFont(ofSize: 18, weight: .bold)
        priceLabel.textAlignment = .center
        contentView.addSubview(priceLabel)

        // Description Label
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(descriptionLabel)

        // Close Button
        closeButton.setTitle("X", for: .normal)
        closeButton.backgroundColor = .lightGray
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        closeButton.layer.cornerRadius = 25
        addSubview(closeButton)

        // Add Button
        addButton.setTitle("담기", for: .normal)
        addButton.backgroundColor = .systemGreen
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        addButton.layer.cornerRadius = 25
        addSubview(addButton)
    }

    private func setupLayout() {
        // 스크롤 뷰 제약 설정
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // Content View 제약 설정
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        authorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        bookImageView.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(350)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(contentView).offset(-20)
        }

        closeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.width.height.equalTo(60)
        }

        addButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(280)
            $0.height.equalTo(60)
        }
    }
}
