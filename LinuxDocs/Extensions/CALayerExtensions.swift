//
//  CALayerExtensions.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/11/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
