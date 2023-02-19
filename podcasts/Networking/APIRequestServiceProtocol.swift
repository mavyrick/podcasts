//
//  APIRequestServiceProtocol.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 10..
//

protocol APIRequestServiceProtocol {
    func getData<T: Decodable>(for urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}
