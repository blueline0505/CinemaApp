//
//  APIError.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/3/4.
//

import Foundation

enum APIError: Error {
    case timeout
    case pageNotFound
    case httpError(HTTPURLResponse)
    case urlError
    case serverError
    case invalidData
    case noNetwork
    case statusMessage(message: String)
    case invalidResponse(httpStatusCode: Int)
    case decodingError(Error)
    case connectionError(Error)
    case invalidAuthentication
    case unknownError
}

extension APIError {
    var desc: String {
        switch self {
        case .timeout:                    return "Time out"
        case .pageNotFound:               return "Not found"
        case .invalidData:                return "Inval data"
        case .noNetwork:                  return "No internet"
        case .invalidResponse:            return "Invalid response"
        case .invalidAuthentication:      return "Invalid authentication"
        case .statusMessage(let message): return message
        case .decodingError(let error):   return "Decoding Error: \(error.localizedDescription)"
        case .connectionError(let error): return "Network connection Error : \(error.localizedDescription)"
        case .unknownError: return "api fail"
        default: return "api fail"
        }
    }
}

extension APIError {
    static func errorType(type: Int) -> APIError {
        switch type {
        case 400..<500:
            return APIError.invalidAuthentication
        case 500..<600:
            return APIError.serverError
        default:
            return otherErrorType(type: type)
        }
    }
    
    private static func otherErrorType(type: Int) -> APIError {
        switch type {
        case -1001:
            return APIError.timeout
        case -1009:
            return APIError.noNetwork
        default:
            return APIError.unknownError
        }
    }
}
