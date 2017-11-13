//
//  Constant.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/11/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import Foundation

enum Constant {
    static let manPagesLocation = Bundle.main.path(forResource: "manpages", ofType: "json")
    static let cheatsheetsLocation = Bundle.main.path(forResource: "cheatsheets", ofType: "json")
}
