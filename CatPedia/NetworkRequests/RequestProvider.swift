//
//  RequestProvider.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import Foundation

// MARK: - Configure

class RequestProvider {
    
    func getCatBreeds(completed:@escaping(Result<[CatBreedResponse],CustomErrors>) -> Void) {
        
        let endpoint = "https://api.thecatapi.com/v1/breeds"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data,response,error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidDataResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print(data)
                
                let listings  = try decoder.decode([CatBreedResponse].self, from: data)
                completed(.success(listings))
            }
            catch {
                completed(.failure(.invalidDataResponse))
                print(String(describing: error))
            }
        }
        
        task.resume()
    }
    

}
