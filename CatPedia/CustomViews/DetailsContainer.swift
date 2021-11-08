//
//  DetailsContainer.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import UIKit

class DetailsContainer: UIView {
    
    // MARK: - Properties
    
    private lazy var bodyLabel: BodyLabel = {
        let bodyText   =  BodyLabel(textAlignment: .left, fontsSize: 12)
        bodyText.textColor = .lightGray
        bodyText.font = UIFont(name:"LuxoraGrotesk-Bold", size: 12)
        bodyText.text = "Body"
        return bodyText
    }()
    
    private lazy var titleLabel: TitleLabel = {
        let titleLabel = TitleLabel(textAlignment:.left , fontsSize:  15, fontWeight: .semibold)
        titleLabel.text = "Title"
        titleLabel.textColor = .appPurple
        return titleLabel
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure

    private func configure() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.layer.cornerRadius = 8
    }
    // MARK: - Configure Constraints
    
    private func configureConstraints() {
        addSubview(titleLabel)
        addSubview(bodyLabel)
        titleLabel.centerX(inView: self, topAnchor: self.topAnchor, paddingTop: 6)
        bodyLabel.centerX(inView: self, topAnchor: titleLabel.bottomAnchor, paddingTop: 5)
    }
    
    func configureData(title:Int,body:String) {
        titleLabel.text = "\(title)"
        bodyLabel.text  = body
    }
}
