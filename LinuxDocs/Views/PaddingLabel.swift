//
//  PaddingLabel.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/12/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft], radius: 5)
    }
}
