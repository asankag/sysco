//
//  Planet.swift
//  Sysco LABS
//
//  Created by AsankaTipple on 7/23/22.
//

import Foundation

struct Planets: Codable {
    let results: [results]
}

public struct results: Codable {
    let name: String
    let climate: String
    let orbital_period: String
    let gravity: String
}
