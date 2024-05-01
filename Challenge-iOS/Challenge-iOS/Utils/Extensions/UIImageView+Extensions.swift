//
//  UIImageView+Extensions.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                // Error handling...
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
}
