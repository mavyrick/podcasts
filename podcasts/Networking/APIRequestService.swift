//
//  APIRequestService.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 08..
//

import Foundation

class APIRequestService: APIRequestServiceProtocol {
    
    // Because of the use of generics any model type passed in can be decoded to making this code reusable.
    //
    // Built in Result type is used here for convenience.
    func getData<T: Decodable>(for urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data {
                do {
                    let object = try decoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }
        task.resume()
    }
    
}
