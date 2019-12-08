//
//  HomeDataController.swift
//  PlayersApp
//
//  Created by sergio blanco martin on 03/12/2019.
//  Copyright © 2019 sergio blanco martin. All rights reserved.
//

import Foundation

class HomeDataController {
    let dataController = DataServiceController()
 
    func getPlayers(completion: @escaping ([PlayerResponse]?, Error?) -> ()) {
        dataController.getPlayers([PlayerResponse].self) { (result, error) in
          
            completion(result, error as? Error)
        }
    }
}
