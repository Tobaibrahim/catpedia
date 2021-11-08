//
//  CatBreedsVM.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import UIKit
import RxRelay
import RxSwift

class CatBreedsVM: NSObject {
    
    //  MARK: - Init
    private let catBreedRequest: RequestProvider
        
    init(catBreedRequest:RequestProvider) {
        self.catBreedRequest = catBreedRequest
    }
    
    // MARK: - Properties
    
     var catBreedResponse: [CatBreedResponse] = [] {
        didSet {
            breedListLoadedRelay.accept(catBreedResponse)
        }
    }
    
    private let breedListLoadedRelay:BehaviorRelay< [CatBreedResponse]?> = BehaviorRelay(value: nil)
    var breedListLoaded: Observable<[CatBreedResponse]?> {
        return breedListLoadedRelay.asObservable()
    }
        
    private let selectedIndexRelay:BehaviorRelay< Bool> = BehaviorRelay(value: false)
    var selectedIndex: Observable<Bool> {
        return selectedIndexRelay.asObservable()
    }
    
    var index = 0
    
    //  MARK: - Requests
    
    func requestCatBreeds() {
        catBreedRequest.getCatBreeds { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let success):
                self.catBreedResponse = success
            case .failure(let failure):
                print("DEBUG: Listing request failed \(failure.rawValue)")
            }
        }
    }
}

//  MARK: - CollectionView Delegate Methods

extension CatBreedsVM: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catBreedResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: CatBreedCell.reuseID, for: indexPath) as? CatBreedCell else { return UICollectionViewCell() }
        cell.configureData(response: (catBreedResponse[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexRelay.accept(true)
        index = indexPath.row
        selectedIndexRelay.accept(false)
    }
}
