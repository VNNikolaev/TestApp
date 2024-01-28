//
//  MainConstraintCell.swift
//  TestApp
//
//  Created by Nikolaev Vasiliy on 28.01.2024.
//

import UIKit

class MainConstraintCell: UITableViewCell {
    
    static var identifier: String {
        "MainConstraintCell"
    }
    
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private var contentStackView = UIStackView()
    private var textStackView = UIStackView()
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    func setupCell(with viewModel: MainCellViewModel) {
        nameLabel.text = viewModel.character.name
        statusLabel.text = viewModel.character.status
        guard let url = URL(string: viewModel.character.image) else { return }
        image.load(url: url)
    }
}

extension MainConstraintCell {
    private func setupViews() {
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        textStackView = UIStackView(arrangedSubviews: [nameLabel, statusLabel])
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.axis = .vertical
        textStackView.spacing = 10
        
        image.backgroundColor = .gray
        
        contentStackView = UIStackView(arrangedSubviews: [image, textStackView])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.alignment = .center
        contentStackView.spacing = 16
        contentStackView.backgroundColor = .lightGray
        contentStackView.layer.cornerRadius = 10
        contentStackView.clipsToBounds = true
        
        addSubview(contentStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 90),
            image.widthAnchor.constraint(equalToConstant: 90),

            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
        ])
    }
}
