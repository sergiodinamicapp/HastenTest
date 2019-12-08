//
//  HomeModel.swift
//  PlayersApp
//
//  Created by sergio blanco martin on 03/12/2019.
//  Copyright © 2019 sergio blanco martin. All rights reserved.
//

import Foundation

protocol HomeModelDelegate {
    func getPlayers(completion: @escaping ([PlayerResponse]?, Error?) -> ())
}

class HomeModel: HomeModelDelegate {
    var dataController = HomeDataController()
    
    func getPlayers(completion: @escaping ([PlayerResponse]?, Error?) -> ()) {
        dataController.getPlayers { (result, error) in
            completion(result, error)
        }
    }
}
