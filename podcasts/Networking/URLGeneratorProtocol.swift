//
//  URLGeneratorProtocol.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 10..
//

protocol URLGeneratorProtocol {
    // It is assumed at this point that a search request URL will have a term, limit, and entity.
    func generateSearchURLString<T>(term: String, limit: Int, entity: T) -> String
}
