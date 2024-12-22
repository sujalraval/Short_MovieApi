//
//  ApiManager.swift
//  movieapicore
//
//  Created by Manthan Mittal on 22/12/2024.
//

import Foundation
import Alamofire

class ApiManager{
    
    let urlstr="https://dummyapi.online/api/movies"
    
    func fetchMovie(completionHandler: @escaping(Result<[MovieModel],Error>)-> Void) {
        
        
        
        AF.request(urlstr).responseDecodable(of: [MovieModel].self){response in
            switch response.result{
                
            case.success(let data):
                completionHandler(.success(data))
                
            case.failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
}
