//
//  OnboardingVC.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import UIKit

class OnboardingVC: UIViewController {
    
    // MARK: - Init
    
    init(catBreedsVM:CatBreedsVM) {
        self.catBreedsVM = catBreedsVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private var catBreedsVM: CatBreedsVM
    
    private lazy var titleLabel: TitleLabel = {
        let titleLabel = TitleLabel(textAlignment:.center , fontsSize:  25, fontWeight: .semibold)
        titleLabel.text = "Ready to explore the \n world of cats?"
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        return titleLabel
    }()
    
    private lazy var bodyLabel: BodyLabel = {
        let bodyText   =  BodyLabel(textAlignment: .center, fontsSize: 17)
        bodyText.text = "We have a huge list of cat breeds \n available for you to explore."
        bodyText.textColor = .darkGray
        view.addSubview(bodyText)
        return bodyText
    }()
        
    private lazy var textContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        view.addSubview(container)
        return container
    }()
    
    private lazy var exploreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Explore", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .appPurple
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleExploreButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        return button
    }()
    
    private lazy var imageView: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "CAT6")
        imageView.clipsToBounds = false
        view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "icon")
        iconImageView.setDimensions(width: 100, height: 100)
        iconImageView.layer.cornerRadius = 100 / 2
        iconImageView.backgroundColor = UIColor.appPurple
        iconImageView.layer.borderWidth = 7
        iconImageView.layer.borderColor = UIColor.white.cgColor
        view.addSubview(iconImageView)
        return iconImageView
    }()
    
    
    // MARK: -  LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: -  ConfigureUI

    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white.withAlphaComponent(0.95)
        configureConstraints()
        catBreedsVM.requestCatBreeds()
    }
    
    private func configureConstraints() {
        
        textContainer.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, height: view.frame.height / 2)
        
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: textContainer.topAnchor, trailing: view.trailingAnchor,paddingTop: 60)
        
        iconImageView.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: view.frame.height / 2.2)
                
        titleLabel.centerX(inView: textContainer, topAnchor: textContainer.topAnchor, paddingTop: 70)
        
        bodyLabel.centerX(inView: textContainer, topAnchor: titleLabel.bottomAnchor, paddingTop: 20)
        
        exploreButton.anchor(top: bodyLabel.bottomAnchor, leading: textContainer.leadingAnchor,trailing: textContainer.trailingAnchor,paddingTop: 60,paddingLeft: 30,paddingRight: 30,height: 60)
        
        imageView.sendSubviewToBack(view)
    }
    
    // MARK: - Handlers
    
    @objc private func handleExploreButtonPressed() {
        let destVC = CatBreedsVC(catBreedsVM: catBreedsVM)
        navigationController?.pushViewController(destVC, animated: true)
    }
}

