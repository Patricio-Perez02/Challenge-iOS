//
//  BaseViewController.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//

import UIKit

class BaseViewController: UIViewController {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var backgroundView: UIView = UIView()
    
    enum Constant {
        static let backgroundAnchor: CGFloat = 66.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showSpinner() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        backgroundView.frame = CGRectMake(0, 0, Constant.backgroundAnchor, Constant.backgroundAnchor)
        backgroundView.center = view.center
        backgroundView.backgroundColor = .black
        backgroundView.layer.cornerRadius = 8.0
        backgroundView.alpha = 0.5
        
        view.addSubview(backgroundView)
    }

    func hideSpinner() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
    }
}
