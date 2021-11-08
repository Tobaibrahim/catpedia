//
//  CustomImageView.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import UIKit

class CustomImageView: UIImageView {
    
    // MARK: - Properties
    
    private let cache = NSCache<NSString,UIImage>()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - ConfigureUI

    private func configure() {
        
        layer.cornerRadius = 10
        clipsToBounds      = true
        translatesAutoresizingMaskIntoConstraints = false
        contentMode        = .scaleAspectFill
        clipsToBounds      = true
    }
    
    func downloadImage(from urlString:String) {
        if let image = cache.object(forKey: urlString as NSString) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            
            guard let self = self else {return}
            
            if error != nil {return}
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {return}
            
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            
            self.cache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
