//
//  CategoryDetailViewModel.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//

import UIKit

protocol CategoryDetailViewModelProtocol {
    var category: Category { get }
    var items: [CategoryDetailData] { get }
    var filteredItems: [CategoryDetailData] { get }
    var errorType: CategoryDetailTypeError { get }
    var isLoading: Bool { get }
    
    func getCategoryDetail(onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void)
    func filterItem(with searchedText: String, onComplete: @escaping () -> Void)
    func loadMoreItems()
    func activePagination()
}

class CategoryDetailViewModel: CategoryDetailViewModelProtocol {
    var category: Category
    var items: [CategoryDetailData] = []
    var filteredItems: [CategoryDetailData] = []
    var isLoading: Bool = false
    var errorType: CategoryDetailTypeError = .emptyData
    
    private let networkManager: NetworkProtocol
    private var itemsOffset: Int = 0
    
    init(category: Category, networkManager: NetworkProtocol = NetworkHandler.shared) {
        self.networkManager = networkManager
        self.category = category
    }
    
    func getCategoryDetail(onSuccess: @escaping (Bool) -> Void, onFailure: @escaping (Error?) -> Void) {
        guard let id = category.id else { onFailure(nil) ; return }
        isLoading = true
        networkManager.getCategoryDetail(id: id, itemsOffset: itemsOffset) { [weak self] result in
            guard let self else { onFailure(nil); return }
            self.isLoading = false
            switch result {
            case .success(let response):
                items = response.data ?? []
                filteredItems = items
                errorType = .emptyData
                onSuccess(response.data?.isEmpty ?? false)
            case .failure(let error):
                errorType = .networkError
                debugPrint(error.localizedDescription)
                onFailure(error)
            }
        }
    }
    
    func filterItem(with searchText: String = "", onComplete: @escaping () -> Void) {
        if searchText.isEmpty {
           // If the search text is empty, show all original data
           filteredItems = items
       } else {
           // Filter the original data based on the search text
           filteredItems = items.filter({ (item: CategoryDetailData) -> Bool in
               guard let title = item.title else { return false }
               return title.range(of: searchText, options: .caseInsensitive) != nil
           })
       }
       
        onComplete()
    }
    
    func loadMoreItems() {
        itemsOffset += 10
        debugPrint("ITEMS LOADED ------> \(itemsOffset)")
    }
    
    func activePagination() {
        self.isLoading = false
    }
}
