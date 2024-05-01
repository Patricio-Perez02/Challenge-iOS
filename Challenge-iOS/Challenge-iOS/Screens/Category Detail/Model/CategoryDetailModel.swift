//
//  CategoryDetailModel.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 01/05/2024.
//

import Foundation
import UIKit

enum CategoryDetailTypeError {
    case networkError
    case emptyData
    
    var description: String {
        switch self {
        case .networkError:
            return "Ocurrio un error al cargar la categoria"
        case .emptyData:
            return "No encontramos ningún item en esta categoria"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .networkError:
            return UIImage(systemName: "exclamationmark.triangle")
        case .emptyData:
            return UIImage(systemName: "exclamationmark.icloud.fill")
        }
    }
    
    var color: UIColor {
        switch self {
        case .networkError:
            return .red
        case .emptyData:
            return .darkGray
        }
    }
}
