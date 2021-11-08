//
//  CatBreedResponse.swift
//  CatPedia
//
//  Created by toba ibrahim on 21/10/2021.
//

import Foundation

struct CatBreedResponse:Codable {
    let name: String?
    let temperament: String?
    let energyLevel: Int?
    let wikipediaUrl: String?
    let origin:String?
    let description:String?
    let childFriendly:Int?
    let intelligence:Int?
    let image: Image?
}

// MARK: - Image
struct Image:Codable {
    let url: String?
}

