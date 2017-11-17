//
//  Constant.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/11/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import Foundation

struct ManPages {
    static let location = Bundle.main.path(forResource: "manpages", ofType: "json")
}

struct Cheatsheets {
    static let location = Bundle.main.path(forResource: "cheatsheets", ofType: "json")
}
