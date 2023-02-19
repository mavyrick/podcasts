//
//  ITunesURLGenerator.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 10..
//

// Enumeration if other search entities are required in the future. By using this the entity can be easily changed.
enum ITunesSearchEntity {
    case podcast
    case movie
    case music
    case musicVideo
    case audiobook
    case shortFilm
    case tvShow
    case software
    case ebook
    case all
}

class ITunesURLGenerator: URLGeneratorProtocol {
    
    func generateSearchURLString<T>(term: String, limit: Int, entity: T) -> String {
        let parsedTerm = term.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(parsedTerm)&limit=\(limit)&entity=\(entity)"
        
        return urlString
    }
    
}
