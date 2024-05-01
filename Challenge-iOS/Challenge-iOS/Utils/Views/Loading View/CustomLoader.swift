//
//  CustomLoader.swift
//  TFW
//
//  Created by Dante Puglisi on 1/26/24.
//

import Foundation
import UIKit

class CustomLoader {
    static let loadingVC = LoadingViewController()
    
    static func show() {
        DispatchQueue.main.async {
            loadingVC.view.alpha = 0.0
            loadingVC.playAnimation()
            loadingVC.view.frame = Global.window?.bounds ?? CGRect.zero
            Global.window?.addSubview(loadingVC.view)
            UIView.animate(withDuration: 0.2) {
                self.loadingVC.view.alpha = 1.0
            }
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.loadingVC.view.alpha = 0.0
            } completion: { _ in
                self.loadingVC.view.removeFromSuperview()
                self.loadingVC.stopAnimation(withMessage: nil)
            }
        }
    }
    
    static func hideWithError(_ message: String?) {
        DispatchQueue.main.async {
            self.loadingVC.stopAnimation(withMessage: message)
            UIView.animate(withDuration: 0.2, delay: 2.2) {
                self.loadingVC.view.alpha = 0.0
            } completion: { _ in
                self.loadingVC.view.removeFromSuperview()
            }
        }
    }
}
