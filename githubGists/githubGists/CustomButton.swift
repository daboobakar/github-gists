//
//  CustomButton.swift
//  githubGists
//
//  Created by Danyal Aboobakar on 27/03/2017.
//  Copyright © 2017 Danyal Aboobakar. All rights reserved.
//

import UIKit


class CustomButton: UIButton {
   
    override func awakeFromNib() {
        
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(displayP3Red: shadowColour, green: shadowColour, blue: shadowColour, alpha: 0.5) .cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
    }
}
