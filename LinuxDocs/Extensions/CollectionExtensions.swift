//
//  CollectionExtensions.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/17/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import Foundation

extension Collection {
    func dictionary<K, V>(transform:(_ index: Int, _ element: Iterator.Element) -> [K : V]) -> [K : V] {
        var dictionary = [K : V]()
        self.enumerated().forEach { index, element in
            for (key, value) in transform(index, element) {
                dictionary[key] = value
            }
        }
        return dictionary
    }
}
