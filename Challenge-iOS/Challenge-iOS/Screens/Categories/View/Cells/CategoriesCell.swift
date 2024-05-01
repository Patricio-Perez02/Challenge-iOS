//
//  CategoriesCell.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//

import UIKit

class CategoriesCell: UITableViewCell {
    enum Constant {
        static let nibName: String = String(describing: CategoriesCell.self)
        static let reuseIdentifier: String = String(describing: CategoriesCell.self)
        
        enum UI {
            static let cornerRadius: CGFloat = 4.0
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        self.selectionStyle = .none
        containerView.layer.cornerRadius = Constant.UI.cornerRadius
        containerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowRadius = Constant.UI.cornerRadius
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    }
    
    public func configure(with category: Category) {
        categoryTitle.text = category.name
    }
}
