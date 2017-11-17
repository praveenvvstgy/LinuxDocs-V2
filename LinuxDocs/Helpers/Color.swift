//
//  Color.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/17/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit
import ChameleonFramework

struct Color {
    static let segmentColors = [
        FlatRed(),
        FlatNavyBlue(),
        FlatSkyBlue(),
        FlatWatermelon(),
        FlatTeal(),
        FlatPurple(),
        FlatGray(),
        FlatCoffee(),
        FlatMagenta(),
        FlatMaroon(),
        FlatBlue(),
        FlatPowderBlueDark()
    ]
    
    static func colors(forCategories categories: [String]) -> [String: UIColor] {
        return categories.dictionary(transform: { (index, category) -> [String : UIColor] in
            return [category: segmentColors[index % segmentColors.count]]
        })
    }
}
