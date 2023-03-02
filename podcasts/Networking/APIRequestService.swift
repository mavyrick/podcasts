//
//  APIRequestService.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 19..
//

import Foundation
import Combine

class APIRequestService: APIRequestServiceProtocol {
    
    func getData<T>(for urlString: String) -> AnyPublisher<T, APIError> where T: Decodable {
        
        guard let url = URL(string: urlString) else {
            let error = APIError.parsing(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch({ _ in
                let error = APIError.network(description: "There was a network error")
                return Fail<T, APIError>(error: error).eraseToAnyPublisher()
            })
                .eraseToAnyPublisher()
    }
    
    
}
