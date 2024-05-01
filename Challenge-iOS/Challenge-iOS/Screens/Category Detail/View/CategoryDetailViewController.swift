//
//  CategoryDetailViewController.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//

import UIKit

class CategoryDetailViewController: BaseViewController {
    enum Constant {
        static let nibName: String = String(describing: CategoryDetailViewController.self)
        
        enum UI {
            static let rowHeight: CGFloat = 100.0
        }
    }
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorDescription: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    private let searchBarController = UISearchController(searchResultsController: nil)

    var viewModel: CategoryDetailViewModelProtocol
    
    init(category: Category) {
        viewModel = CategoryDetailViewModel(category: category)
        super.init(nibName: Constant.nibName, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.category.name ?? "Categoria no encontrada"
        setupTableView()
        getCategoryDetail()
        setSearchBarUI()
    }
    
    private func getCategoryDetail() {
        CustomLoader.show()
        viewModel.getCategoryDetail { [weak self] isDataEmpty in
            guard let self else { return }
            CustomLoader.hide()
            
            if isDataEmpty {
                self.setErrorUI()
                return
            }
            
            self.reloadTableView()
        } onFailure: { [weak self] _ in
            guard let self else { return }
            CustomLoader.hide()
            self.setErrorUI()
        }
    }
    
    func setSearchBarUI() {
        searchBarController.searchBar.delegate = self
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.sizeToFit()
        navigationItem.searchController = searchBarController
    }
    
    private func setErrorUI() {
        errorView.isHidden = false
        tableView.isHidden = true
        let errorType = viewModel.errorType
        let errorColor = errorType.color
        errorImageView.image = errorType.icon
        errorImageView.tintColor = errorColor
        errorDescription.text = errorType.description
        errorDescription.textColor = errorColor
        retryButton.isHidden = errorType == .emptyData
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: CategoryDetailCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: CategoryDetailCell.Constant.reuseIdentifier)
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.errorView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    @IBAction func retryAction(_ sender: Any) {
        getCategoryDetail()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDetailCell.Constant.reuseIdentifier, for: indexPath) as? CategoryDetailCell else { return UITableViewCell() }
        let item = viewModel.filteredItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.UI.rowHeight
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height * 2 && !viewModel.isLoading {
            self.viewModel.loadMoreItems()
            self.getCategoryDetail()
        }
    }
}

extension CategoryDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems(with: searchText.isEmpty ? "" : searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        filterItems()
    }
    
    private func filterItems(with searchText: String = "") {
        viewModel.filterItem(with: searchText) { [weak self] in
            guard let self else { return }
            self.reloadTableView()
        }
    }
}
