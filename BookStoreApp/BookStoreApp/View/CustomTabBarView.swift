//
//  TabBarView.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/5/25.
//

import Foundation
import UIKit
import SnapKit

class CustomTabBarView: UIView {
    let searchTabButton = UIButton(type: .system)
    let savedBooksTabButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        
        // 검색 탭 버튼 설정
        searchTabButton.setTitle("검색 탭", for: .normal)
        searchTabButton.setTitleColor(.black, for: .normal)
        searchTabButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        searchTabButton.layer.borderWidth = 1
        searchTabButton.layer.borderColor = UIColor.black.cgColor
        searchTabButton.layer.cornerRadius = 5
        addSubview(searchTabButton)

        // 담은 책 리스트 탭 버튼 설정
        savedBooksTabButton.setTitle("담은 책 리스트 ", for: .normal)
        savedBooksTabButton.setTitleColor(.black, for: .normal)
        savedBooksTabButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        savedBooksTabButton.layer.borderWidth = 1
        savedBooksTabButton.layer.borderColor = UIColor.black.cgColor
        savedBooksTabButton.layer.cornerRadius = 5
        addSubview(savedBooksTabButton)
    }

    private func setupLayout() {
        let buttonWidth = UIScreen.main.bounds.width / 2 - 30 // 버튼 너비 균등화
        let buttonHeight: CGFloat = 50 // 버튼 높이 지정
        
        searchTabButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview().offset(-10) // 버튼 위치 조정
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonHeight)
        }

        savedBooksTabButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview().offset(-10) // 버튼 위치 조정
            $0.width.equalTo(buttonWidth)
            $0.height.equalTo(buttonHeight)
        }
    }
}
