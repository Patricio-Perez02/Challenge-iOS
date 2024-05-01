//
//  Paging.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//

import Foundation

struct Paging: Codable, Equatable {
    let total, primary, offset, limit: Int?
        
    enum CodingKeys: String, CodingKey {
        case total, offset, limit
        case primary = "primary_results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        total = (try? container.decodeIfPresent(Int.self, forKey: .total)) ?? nil
        primary = (try? container.decodeIfPresent(Int.self, forKey: .primary)) ?? nil
        offset = (try? container.decodeIfPresent(Int.self, forKey: .offset)) ?? nil
        limit = (try? container.decodeIfPresent(Int.self, forKey: .limit)) ?? nil
    }
    
    init(total: Int? = nil, primary: Int? = nil, offset: Int? = nil, limit: Int? = nil) {
        self.total = total
        self.primary = primary
        self.offset = offset
        self.limit = limit
    }
}
