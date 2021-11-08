//
//  CatBreedDetailsVC.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import UIKit

class CatBreedDetailsVC: UIViewController {
    
    // MARK: - Init
    
    init(catBreedsVM:CatBreedsVM) {
        self.catBreedsVM = catBreedsVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
        
    private lazy var titleLabel: TitleLabel = {
        let titleLabel = TitleLabel(textAlignment:.left , fontsSize:  25, fontWeight: .semibold)
        titleLabel.text = "Title"
        titleLabel.textColor = .darkGray
        return titleLabel
    }()
    
    private lazy var temperamentLabel: BodyLabel = {
        let temperamentLabel = BodyLabel(textAlignment: .left, fontsSize: 20)
        temperamentLabel.text = "Temperament"
        temperamentLabel.textColor = .darkGray
        return temperamentLabel
    }()
    
    private lazy var bodyLabel: BodyLabel = {
        let bodyLabel   =  BodyLabel(textAlignment: .left, fontsSize: 16)
        bodyLabel.textColor = .lightGray
        bodyLabel.lineBreakMode = .byWordWrapping
        bodyLabel.numberOfLines = 4
        return bodyLabel
    }()
    
    private lazy var locationLabel: BodyLabel = {
        let bodyText   =  BodyLabel(textAlignment: .left, fontsSize: 16)
        bodyText.text = "Location Text"
        bodyText.textColor = .lightGray
        return bodyText
    }()
    
    private lazy var locationIcon: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "pin2")?.withRenderingMode(.alwaysTemplate)
        iconImageView.setDimensions(width: 25, height: 25)
        iconImageView.layer.cornerRadius = 25 / 2
        iconImageView.tintColor = UIColor.appPurple
        return iconImageView
    }()
        
    private lazy var textContainer: UIView = {
        let textContainer = UIView()
        textContainer.backgroundColor = .white
        textContainer.layer.cornerRadius = 20
        textContainer.addSubview(titleLabel)
        textContainer.addSubview(locationIcon)
        textContainer.addSubview(locationLabel)
        textContainer.addSubview(bodyLabel)
        textContainer.addSubview(wikiButton)
        textContainer.addSubview(temperamentLabel)
        textContainer.addSubview(stackView)
        view.addSubview(textContainer)
        return textContainer
    }()
    
    private lazy var wikiButton: UIButton = {
        let wikiButton = UIButton(type: .system)
        wikiButton.setTitle("Wikipedia", for: .normal)
        wikiButton.setTitleColor(.white, for: .normal)
        wikiButton.backgroundColor = .appPurple
        wikiButton.layer.cornerRadius = 10
        wikiButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        wikiButton.addTarget(self, action: #selector(handleWikiButtonPressed), for: .touchUpInside)
        return wikiButton
    }()
    
    private lazy var imageView: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var backButton: UIImageView = {
        let backButton = UIImageView()
        backButton.image = UIImage(systemName: "arrow.backward.circle.fill")
        backButton.clipsToBounds = true
        backButton.contentMode = .scaleAspectFit
        backButton.tintColor = .white
        backButton.backgroundColor = .black.withAlphaComponent(0.2)
        backButton.layer.cornerRadius = 25 / 2
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(navigateBackToList)))
        backButton.isUserInteractionEnabled = true
        backButton.setDimensions(width: 25, height: 25)
        view.addSubview(backButton)
        return backButton
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.addArrangedSubview(intelligenceLevelDetailsContainer)
        stackView.addArrangedSubview(energyLevelDetailsContainer)
        stackView.addArrangedSubview(childFriendlyDetailsContainer)
        return stackView
    }()
    
    private let energyLevelDetailsContainer = DetailsContainer()
    
    private let childFriendlyDetailsContainer = DetailsContainer()
    
    private let intelligenceLevelDetailsContainer = DetailsContainer()
    
    private var catBreedsVM: CatBreedsVM
        
    // MARK: -  LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: -  ConfigureUI

    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .appBackground
        
        configureConstraints()
        configureData()
    }
    
    private func configureConstraints() {
        
        textContainer.anchor(leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, height: view.frame.height / 2)
        
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: textContainer.topAnchor, trailing: view.trailingAnchor,paddingBottom: -10)
        
        titleLabel.anchor(top: textContainer.topAnchor, leading: textContainer.leadingAnchor,paddingTop: 25,paddingLeft: 30)
        
        locationIcon.anchor(top: titleLabel.bottomAnchor, leading: textContainer.leadingAnchor,paddingTop: 10,paddingLeft: 30)
        
        locationLabel.anchor(top: titleLabel.bottomAnchor, leading: locationIcon.trailingAnchor,paddingTop: 15,paddingLeft: 8)
        
        wikiButton.anchor(top:bodyLabel.bottomAnchor,leading: textContainer.leadingAnchor,trailing: textContainer.trailingAnchor,paddingTop: 17,paddingLeft: 30,paddingRight: 30,height: 50)
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor,paddingTop: 40,paddingLeft: 30)
        
        stackView.anchor(top: locationLabel.bottomAnchor, leading:textContainer.leadingAnchor,trailing: textContainer.trailingAnchor,paddingTop: 20,paddingLeft: 30,paddingRight: 30,height: 50)
        
        temperamentLabel.anchor(top: stackView.bottomAnchor, leading:textContainer.leadingAnchor,trailing: textContainer.trailingAnchor,paddingTop: 18,paddingLeft: 30,paddingRight: 30)
        
        bodyLabel.anchor(top: temperamentLabel.bottomAnchor, leading:textContainer.leadingAnchor,trailing: textContainer.trailingAnchor,paddingTop: 15,paddingLeft: 30,paddingRight: 30)

        view.bringSubviewToFront(textContainer)
    }
    
    private func configureData() {
        titleLabel.text =  catBreedsVM.catBreedResponse[catBreedsVM.index].name
        locationLabel.text = catBreedsVM.catBreedResponse[catBreedsVM.index].origin
        imageView.downloadImage(from: catBreedsVM.catBreedResponse[catBreedsVM.index].image?.url ?? "")
        bodyLabel.text = catBreedsVM.catBreedResponse[catBreedsVM.index].temperament
        
        childFriendlyDetailsContainer.configureData(title: catBreedsVM.catBreedResponse[catBreedsVM.index].childFriendly ?? 0, body: "Child Friendly")
        energyLevelDetailsContainer.configureData(title: catBreedsVM.catBreedResponse[catBreedsVM.index].energyLevel ?? 0, body: "Energy")
        intelligenceLevelDetailsContainer.configureData(title:catBreedsVM.catBreedResponse[catBreedsVM.index].intelligence ?? 0, body: "Intelligence")
    }
    
    // MARK: - Handlers
    
    @objc private func handleWikiButtonPressed() {
        guard let url = URL(string:catBreedsVM.catBreedResponse[catBreedsVM.index].wikipediaUrl ?? "") else { return }
        presentSafariVC(with: url)
    }
    
    @objc private func navigateBackToList() {
        let destVC = CatBreedsVC(catBreedsVM:catBreedsVM)
        navigationController?.pushViewController(destVC, animated: true)
    }
}
