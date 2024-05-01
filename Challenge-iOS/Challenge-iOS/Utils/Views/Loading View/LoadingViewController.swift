//
//  LoadingViewController.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 30/04/2024.
//
import UIKit
import Lottie

class LoadingViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var animationContainerView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageBackView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    
    private var animationView = LottieAnimationView(name: "loading")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationContainerView.addSubview(animationView)
        animationView.frame = animationContainerView.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1.0
        animationView.loopMode = .loop
        playAnimation()
    }
    
    func playAnimation() {
        messageLabel.text = ""
        
        messageBackView.alpha = 0.0
        errorImageView.alpha = 0.0
        
        animationView.play()
    }
    
    func stopAnimation(withMessage message: String?) {
        messageLabel.text = message
        
        UIView.animate(withDuration: 0.2) {
            self.messageBackView.alpha = 1.0
            self.errorImageView.alpha = 1.0
        }
        
        animationView.stop()
    }
}
