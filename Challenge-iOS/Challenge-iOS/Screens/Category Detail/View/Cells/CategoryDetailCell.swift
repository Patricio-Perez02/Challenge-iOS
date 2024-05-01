//
//  CategoryDetailCell.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//

import UIKit

class CategoryDetailCell: UITableViewCell {

    enum Constant {
        static let nibName: String = String(describing: CategoryDetailCell.self)
        static let reuseIdentifier: String = String(describing: CategoryDetailCell.self)
        
        enum UI {
            static let cornerRadius: CGFloat = 14.0
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    private func setup() {
        self.selectionStyle = .none
        containerView.layer.cornerRadius = Constant.UI.cornerRadius
    }
    
    public func configure(with data: CategoryDetailData) {
        itemImageView.setImageFromURL(stringUrl: data.thumbnail ?? "")
        itemLabel.text = data.title ?? "-"
        priceLabel.text = configureCurrency(with: data.price ?? 0.0)
    }
    
    private func configureCurrency(with price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_AR")

        if let precieFormatter = formatter.string(from: NSNumber(value: price)) {
            return "\(precieFormatter)"
        } else {
            return "$0"
        }
    }
}
