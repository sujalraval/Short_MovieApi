//
//  MovieModel.swift
//  movieapicore
//
//  Created by Manthan Mittal on 22/12/2024.
//

import Foundation

struct MovieModel: Codable{
    
    let id:Int
    let movie : String
    let rating : Double
    let image : String
    let imdb_url : String
    
}
