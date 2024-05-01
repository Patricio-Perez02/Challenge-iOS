//
//  CategoriesViewModel.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 29/04/2024.
//

import UIKit

protocol CategoriesViewModelProtocol {
    var items: [Category] { get }
    
    func getCategories(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void)
}

class CategoriesViewModel: CategoriesViewModelProtocol {
    var items: [Category] = []
    
    private let networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol = NetworkHandler.shared) {
        self.networkManager = networkManager
    }
    
    func getCategories(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        networkManager.getCategories { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let categories):
                self.items = categories
                onSuccess()
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
