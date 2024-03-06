//
//  ImageEndPointType.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/6.
//

import Foundation

enum ImageEndPointType {
    case poster(_ id: String = "")
}

extension ImageEndPointType: EndPointType {
    var path: String {
        switch self {
        case .poster(let id):
            return id
        }
    }
    
    var baseURL: String {
        return "https://image.tmdb.org/t/p/w500/"
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        return .get
    }
    
    var body: Encodable? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var localName: String { return "" }
}
