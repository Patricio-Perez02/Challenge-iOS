//
//  Categories.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 29/04/2024.
//

import Foundation

struct Category: Codable, Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id, name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decodeIfPresent(String.self, forKey: .id)) ?? nil
        name = (try? container.decodeIfPresent(String.self, forKey: .name)) ?? nil
    }
    
    init(id: String? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
}
