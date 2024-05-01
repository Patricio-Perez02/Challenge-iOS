//
//  NetworkRequest.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 29/04/2024.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var method: String { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}

enum NetworkRequest: RequestProtocol {
    case categories
    case categoryDetail(id: String, offset: Int)
    
    var path: String {
        switch self {
        case .categories:
            return "/categories"
        case .categoryDetail(let id, let offset):
            return "/search?category=\(id)&offset=\(offset)&limit=10"
        }
    }
    
    var method: String {
        switch self {
        case .categories, .categoryDetail:
            return "GET"
        }
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var headers: [String : String]? {
        return nil
    }
}
