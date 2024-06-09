//
//  PlaceListViewCell.swift
//  great-places-ios
//
//  Created by João Alexandre Bitar on 18/05/24.
//

import UIKit
import Kingfisher
import CoreData

class PlaceListViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "PlaceListViewCell"
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var locationImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 60 / 2
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        locationImage.image = nil
        mainTitle.text = nil
        subtitle.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubview(locationImage)
        addSubview(contentStackView)
        
        for view in [mainTitle, subtitle] {
            contentStackView.addArrangedSubview(view)
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            locationImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            locationImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            locationImage.widthAnchor.constraint(equalToConstant: 60),
            locationImage.heightAnchor.constraint(equalToConstant: 60),
            
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 12),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }
    
    func configureCell(with place: Place) {
        locationImage.image = UIImage(data: place.image)
        mainTitle.text = place.title
        subtitle.text = place.location.address
    }
}
