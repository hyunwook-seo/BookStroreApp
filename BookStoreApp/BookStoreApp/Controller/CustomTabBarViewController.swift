//
//  TabBarController.swift
//  BookStoreApp
//
//  Created by t2023-m0149 on 1/4/25.
//

import UIKit
import SnapKit

class CustomTabBarViewController: UIViewController {
    private let customTabBarView = CustomTabBarView()

    private let bookSearchVC = BookSearchViewController()
    private let bookListVC = BookListViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarView()
        setupInitialViewController()
        setupActions()
    }

    private func setupTabBarView() {
        guard customTabBarView.superview == nil else { return }
        view.addSubview(customTabBarView)
        customTabBarView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
    }

    private func setupInitialViewController() {
        add(asChildViewController: bookSearchVC)
    }

    private func setupActions() {
        customTabBarView.searchTabButton.addTarget(self, action: #selector(showSearchTab), for: .touchUpInside)
        customTabBarView.savedBooksTabButton.addTarget(self, action: #selector(showSavedBooksTab), for: .touchUpInside)
    }

    @objc private func showSearchTab() {
        switchToViewController(bookSearchVC)
    }

    @objc private func showSavedBooksTab() {
        switchToViewController(bookListVC)
    }

    private func switchToViewController(_ viewController: UIViewController) {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        add(asChildViewController: viewController)
    }

    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(customTabBarView.snp.top)
        }
        viewController.didMove(toParent: self)
    }
}
