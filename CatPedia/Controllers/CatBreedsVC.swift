//
//  CatBreedsVC.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import UIKit
import RxRelay
import RxSwift

class CatBreedsVC: UIViewController {
    
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
        titleLabel.text = "Cat Breeds"
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        return titleLabel
    }()
    
    private lazy var container: UIView = {
        let container = UIView()
        view.addSubview(container)
        container.addSubview(collectionView)
        return container
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let width                        = view.bounds.width
        let padding:CGFloat              = 25
        let minimumItemSpacing:CGFloat   = 13
        let availablewidth               = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                    = availablewidth / 2
        
        flowLayout.sectionInset          = UIEdgeInsets(top: 20, left: padding, bottom: 150, right:
                                                            padding)
        flowLayout.itemSize              = CGSize(width: itemWidth, height: 200 )
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .appBackground
        collectionView.register(CatBreedCell.self, forCellWithReuseIdentifier:CatBreedCell.reuseID)
        collectionView.dataSource = catBreedsVM
        collectionView.delegate   = catBreedsVM
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Configure UI
    private func configureUI() {
        view.backgroundColor = .appBackground
        navigationController?.navigationBar.isHidden = true
        configureConstraints()
        subscribe()
    }
    
    private func subscribe() {
        catBreedsVM.selectedIndex.subscribe(onNext: { [weak self] event in
            guard let self = self else { return }
            if event {
                self.pushToDetailsVC()
            }
        })
        .disposed(by: disposeBag)
    }
    
    private func configureConstraints() {
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, paddingTop: 90, paddingLeft: 30)
        container.anchor(top: titleLabel.bottomAnchor, leading: view.leadingAnchor,bottom: view.bottomAnchor, trailing: view.trailingAnchor,paddingTop: 2)
    }
    
    // MARK: - PushVC
    private func pushToDetailsVC() {
        let destVC  = CatBreedDetailsVC(catBreedsVM: catBreedsVM)
        navigationController?.pushViewController(destVC, animated: false)
    }

}
