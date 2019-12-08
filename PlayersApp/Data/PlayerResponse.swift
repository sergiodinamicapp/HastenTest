//
//  PlayerResponse.swift
//  PlayersApp
//
//  Created by sergio blanco martin on 03/12/2019.
//  Copyright © 2019 sergio blanco martin. All rights reserved.
//

import Foundation

class PlayerResponse: Codable {
    let players: [Player]
    let type: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case players = "players"
        case type = "type"
        case title = "title"
    }
}



