//
//  APIRequestServiceProtocol.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 10..
//

import Foundation
import Combine

enum APIError: Error {
  case parsing(description: String)
  case network(description: String)
}

protocol APIRequestServiceProtocol {
    func getData<T: Decodable>(for urlString: String) -> AnyPublisher<T, APIError>
}
