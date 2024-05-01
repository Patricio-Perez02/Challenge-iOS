//
//  Global.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 29/04/2024.
//

import Foundation
import UIKit

struct Global {
    static let baseURL: String = "https://api.mercadolibre.com/sites/\(site)"
    
    // Should request /sites, improvement for the future
    static private let site: String = "MLA"
    
    static let window: UIWindow? = {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.windows.first
    }()
}
