//
//  ManPage.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/11/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import Foundation

/*
 {
     "description": " strip directory and suffix from filenames",
     "folder": "htmlman1",
     "filename": "basename.1",
     "name": "basename",
     "section": "1"
 }
 */

struct ManPage: Codable {
    let name: String
    let description: String
    let fileName: String
    let directory: String
    let section: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case fileName = "filename"
        case directory = "folder"
        case section
    }
}
