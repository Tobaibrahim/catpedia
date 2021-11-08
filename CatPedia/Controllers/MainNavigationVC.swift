//
//  MainNavigationVC.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import UIKit

class MainNavigationVC: UINavigationController {
    
    override func viewDidLoad() {
        configureViewControllers()
    }
    
    private func configureViewControllers() {
        let onboardingVC  = OnboardingVC(catBreedsVM: .init(catBreedRequest: .init()))
        let catBreedsVC   = CatBreedsVC(catBreedsVM:.init(catBreedRequest: .init()))
        let catBreedDetailsVC  = CatBreedDetailsVC(catBreedsVM: .init(catBreedRequest: .init()))

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor     = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .clear
        navigationBar.isTranslucent    = false
        viewControllers                = [catBreedDetailsVC,catBreedsVC,onboardingVC]
        UINavigationBar.appearance().shadowImage  = UIImage()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
}
