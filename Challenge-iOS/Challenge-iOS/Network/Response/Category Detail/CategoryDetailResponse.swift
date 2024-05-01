//
//  CategoryDetailResponse.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//

import Foundation

struct CategoryDetailResponse: Codable, Equatable {
    let siteId, countryTimeZone: String?
    let paging: Paging?
    let data: [CategoryDetailData]?
    
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case countryTimeZone = "country_default_time_zone"
        case paging
        case data = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        siteId = (try? container.decodeIfPresent(String.self, forKey: .siteId)) ?? nil
        countryTimeZone = (try? container.decodeIfPresent(String.self, forKey: .countryTimeZone)) ?? nil
        paging = (try? container.decodeIfPresent(Paging.self, forKey: .paging)) ?? nil
        data = (try? container.decodeIfPresent([CategoryDetailData].self, forKey: .data)) ?? nil
    }
    
    init(siteId: String? = nil, countryTimeZone: String? = nil, paging: Paging? = nil, data: [CategoryDetailData]? = nil) {
        self.siteId = siteId
        self.countryTimeZone = countryTimeZone
        self.paging = paging
        self.data = data
    }
}

struct CategoryDetailData: Codable, Equatable {
    let id, title, condition, thumbnail, currencyID: String?
    let price: Double?
    let store: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, condition, thumbnail, price
        case currencyID = "currency_id"
        case store = "official_store_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = (try? container.decodeIfPresent(String.self, forKey: .id)) ?? nil
        title = (try? container.decodeIfPresent(String.self, forKey: .title)) ?? nil
        condition = (try? container.decodeIfPresent(String.self, forKey: .condition)) ?? nil
        thumbnail = (try? container.decodeIfPresent(String.self, forKey: .thumbnail)) ?? nil
        currencyID = (try? container.decodeIfPresent(String.self, forKey: .currencyID)) ?? nil
        price = (try? container.decodeIfPresent(Double.self, forKey: .price)) ?? nil
        store = (try? container.decodeIfPresent(String.self, forKey: .store)) ?? nil
    }
    
    init(id: String? = nil, title: String? = nil, condition: String? = nil, thumbnail: String? = nil, currencyID: String? = nil, price: Double? = nil, store: String? = nil) {
        self.id = id
        self.title = title
        self.condition = condition
        self.thumbnail = thumbnail
        self.currencyID = currencyID
        self.price = price
        self.store = store
    }
}
