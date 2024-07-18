//
//  LoginViewController.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 17.07.2024.
//

import UIKit
import Kingfisher

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var movieTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTextLabel.backgroundColor = UIColor.clear
        movieTextLabel.layer.borderColor = UIColor.white.cgColor
        movieTextLabel.layer.borderWidth = 2
        
        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 0.1, 0.5, 0.9, 1.0]
        imageView.layer.insertSublayer(gradient, at: 0)
        
        let url = URL(string: "https://i.pinimg.com/564x/20/a4/23/20a4239750efa6d888960faafd1e8708.jpg")
        imageView.kf.setImage(with: url)
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
    }
    
}
