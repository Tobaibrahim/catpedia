//
//  CatBreedCell.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import UIKit

class CatBreedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseID = "CatBreedCell"
    
    private let  titleLabel = TitleLabel(textAlignment: .left, fontsSize: 16, fontWeight: .medium)
    private let  bodyLabel  = BodyLabel(textAlignment:  .left, fontsSize: 13)
    
    private lazy var imageView: CustomImageView = {
        let imageView  = CustomImageView(frame:.zero)
        imageView.layer.cornerRadius = 14
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "icon")
        iconImageView.setDimensions(width: 20, height: 20)
        iconImageView.layer.cornerRadius = 20 / 2
        iconImageView.backgroundColor = UIColor.appPurple
        iconImageView.layer.borderWidth = 2
        iconImageView.layer.borderColor = UIColor.appPurple.cgColor
        addSubview(iconImageView)
        return iconImageView
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Methods
    
    private func configure() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        addSubview(titleLabel)
        addSubview(bodyLabel)
        
        bodyLabel.textColor = .darkGray
        imageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10,height: 130)
        
        titleLabel.anchor(top: imageView.bottomAnchor, leading: self.leadingAnchor,paddingTop: 10, paddingLeft: 10)
        bodyLabel.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor,paddingTop: 5, paddingLeft: 10)

        contentView.addShadow(colour: UIColor.lightGray.cgColor, opacity: 0.2, radius: 10)
    }
    
    func configureData(response:CatBreedResponse) {
        titleLabel.text = response.name
        self.bodyLabel.text = response.origin
        imageView.downloadImage(from:response.image?.url ?? "")
    }
}
