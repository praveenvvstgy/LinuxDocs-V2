//
//  Cheatsheet.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/12/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import Foundation

/*
{
    "platform": "common",
    "description": "A file archiver with high compression ratio.",
    "name": "7za",
    "filename": "7za.html"
}
*/

struct Cheatsheet: Codable {
    let platform: String
    let description: String
    let name: String
    let fileName: String
    
    enum CodingKeys: String, CodingKey {
        case platform
        case description
        case name
        case fileName = "filename"
    }
}
