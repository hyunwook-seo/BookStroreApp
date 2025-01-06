//
//  BookCollectionViewCell.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//

import UIKit
import SnapKit

class BookCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 8

        // Title Label
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail

        // Author Label
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = .darkGray

        // Price Label
        priceLabel.font = .systemFont(ofSize: 16, weight: .bold)
        priceLabel.textColor = .black

        // Stacks
        let horizontalStack = UIStackView(arrangedSubviews: [authorLabel, priceLabel])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 20
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fillProportionally

        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, horizontalStack])
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        verticalStack.alignment = .leading
        verticalStack.distribution = .fill

        addSubview(verticalStack)

        // Layout
        verticalStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    func configure(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.author
        priceLabel.text = book.price.isEmpty ? "가격 없음" : book.price
    }
}
