//
//  EndPointType.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/4.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
    var localName: String { get }
}
