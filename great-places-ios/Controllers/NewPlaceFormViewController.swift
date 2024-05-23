//
//  NewPlaceFormViewController.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 18/05/24.
//

import UIKit

class NewPlaceFormViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "New Place Form"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        title = "New Place Form"
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
