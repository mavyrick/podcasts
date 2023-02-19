//
//  Podcast.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 08..
//

struct PodcastsResults: Codable {
    let resultCount: Int
    let results: [Podcast]
}

struct Podcast: Codable, Hashable, Equatable {
    let trackID: Int
    let artistName: String
    let trackName: String
    let trackViewURL: String
    let artworkURL100: String?
    let artworkURL600: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case trackID = "trackId"
        case artistName
        case trackName
        case trackViewURL = "trackViewUrl"
        case artworkURL100 = "artworkUrl100"
        case releaseDate
        case artworkURL600 = "artworkUrl600"
    }
}
