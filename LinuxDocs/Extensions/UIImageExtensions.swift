//
//  UIImageExtensions.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/16/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit

extension UIImage{
    static func imageWithSize(size : CGSize, color : UIColor = UIColor.white) -> UIImage? {
        var image:UIImage? = nil
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.addRect(CGRect(origin: CGPoint.zero, size: size));
            context.drawPath(using: .fill)
            image = UIGraphicsGetImageFromCurrentImageContext();
        }
        UIGraphicsEndImageContext()
        return image
    }
}
