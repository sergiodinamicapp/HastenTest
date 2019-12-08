//
//  Player.swift
//  PlayersApp
//
//  Created by sergio blanco martin on 03/12/2019.
//  Copyright © 2019 sergio blanco martin. All rights reserved.
//

import Foundation

class Player: Codable {
    let image: String
    let surname: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
        case surname = "surname"
        case name = "name"
    }
}
