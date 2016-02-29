//
//  ColorButton.swift
//  to-do-app-2
//
//  Created by Lucas Alves Sobrinho on 2/25/16.
//  Copyright © 2016 Lucas Alves Sobrinho. All rights reserved.
//

import UIKit

class ColorButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).CGColor
    }
    
}
