//
//  CategoriesViewController.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 29/04/2024.
//

import UIKit

class CategoriesViewController: BaseViewController {
    
    enum Constant {
        static let nibName: String = String(describing: CategoriesViewController.self)
        
        enum UI {
            static let rowHeight: CGFloat = 56.0
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: CategoriesViewModelProtocol = {
        return CategoriesViewModel()
    }()
    
    init() {
        super.init(nibName: Constant.nibName, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Categorias"
        setupTableView()
        getCategories()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: CategoriesCell.Constant.nibName, bundle: nil), forCellReuseIdentifier: CategoriesCell.Constant.reuseIdentifier)
    }
    
    private func getCategories() {
        CustomLoader.show()
        viewModel.getCategories { [weak self] in
            guard let self else { return }
            CustomLoader.hide()
            self.tableView.reloadData()
        } onFailure: { [weak self] error in
            guard let self else { return }
            CustomLoader.hideWithError(error.localizedDescription)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCell.Constant.reuseIdentifier, for: indexPath) as? CategoriesCell else { return UITableViewCell() }
        let item = viewModel.items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.UI.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = viewModel.items[indexPath.row]
        let categoryDetailVC = CategoryDetailViewController(category: category)
        self.navigationController?.pushViewController(categoryDetailVC, animated: true)
    }
}
