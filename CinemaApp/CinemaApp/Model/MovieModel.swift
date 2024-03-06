//
//  MovieModel.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/2/27.
//

import UIKit

struct MovieModel: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

extension MovieModel {
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let backdropPath: String?
    let id: Int
    let title: String?
    let originalTitle: String?
    let originalLanguage: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let mediaType: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let name: String?
    let originalName, firstAirDate: String?
    
    var thumbnailImage: UIImage?
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case title
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case overview, popularity
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
    }
}
