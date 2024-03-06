//
//  MovieEndPointType.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/4.
//

import Foundation

enum MovieEndPointType {
    case movies(_ key: String = "")
}

extension MovieEndPointType: EndPointType {
    var path: String {
        switch self {
        case .movies(let key):
            return "trending/all/day?api_key=\(key)"
        }
    }
    
    var baseURL: String {
        switch self {
        case .movies: return "https://api.themoviedb.org/3/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .movies: return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .movies: return nil
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var localName: String { return "Movies" }
}
