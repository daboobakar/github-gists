//
//  LoginViewController.swift
//  githubGists
//
//  Created by Danyal Aboobakar on 27/03/2017.
//  Copyright © 2017 Danyal Aboobakar. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: class {
    func didTapLoginButton()
}

class LoginViewController : UIViewController {
    weak var delegate: LoginViewDelegate?
    
    @IBAction func tappedLoginButton(_ sender: Any) {
        delegate?.didTapLoginButton()
    }
    
}
