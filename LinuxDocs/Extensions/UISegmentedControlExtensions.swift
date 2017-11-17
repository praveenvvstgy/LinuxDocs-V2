//
//  UISegmentedControlExtensions.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/16/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit

extension UISegmentedControl{
    
    func removeBorder(){
        let backgroundImage = UIImage.imageWithSize(size: bounds.size, color: UIColor.clear)
        setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.imageWithSize(size: CGSize(width: 1.0, height: self.bounds.size.height), color: UIColor.clear)
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    func addBottomBorder(activeColor: UIColor, inActiveColor: UIColor) {
        removeBorder()
        let borderWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let borderHeight: CGFloat = 2.0
        
        let inActiveBorderWidth: CGFloat = self.bounds.size.width
        let inActiveBorderFrame = CGRect(x: 0, y: 0, width: inActiveBorderWidth, height: borderHeight)
        let inActiveBorder = UIView(frame: inActiveBorderFrame)
        inActiveBorder.backgroundColor = inActiveColor
        self.addSubview(inActiveBorder)
        inActiveBorder.translatesAutoresizingMaskIntoConstraints = false
        inActiveBorder.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        inActiveBorder.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        inActiveBorder.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1).isActive = true
        inActiveBorder.heightAnchor.constraint(equalToConstant: borderHeight).isActive = true
        
        let borderFrame = segmentViews.first?.frame ?? CGRect.zero
        let border = UIView(frame: borderFrame)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = activeColor
        border.tag = 1
        self.addSubview(border)
        changeActiveBorderPosition()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func changeActiveBorderPosition(){
        guard let border = self.viewWithTag(1) else {return}
        let segmentViews = subviews
            .filter{ String(describing: type(of: $0)).elementsEqual("UISegment") }
            .sorted{ $0.frame.minX < $1.frame.minX }

        UIView.animate(withDuration: 0.1, animations: {
            let selectedSegment = segmentViews[self.selectedSegmentIndex]
            var frame = selectedSegment.frame
            frame.origin.y = frame.height - 2
            frame.size.height = 2
            border.frame = frame
            border.bounds.size = CGSize(width: selectedSegment.bounds.width, height: 2.0)
        })
    }
    
    var segmentViews: [UIView] {
        get {
            return subviews
                .filter{ String(describing: type(of: $0)).elementsEqual("UISegment") }
                .sorted{ $0.frame.minX < $1.frame.minX }
        }
    }
}

