//
//  HomeViewModel.swift
//  PlayersApp
//
//  Created by sergio blanco martin on 03/12/2019.
//  Copyright © 2019 sergio blanco martin. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate {
    func getPlayers(completion: @escaping ([PlayerResponse]?, Error?) -> ())}

class HomeViewModel {
    fileprivate var viewDelegate: HomeViewControllerDelegate
    fileprivate var modelDelegate: HomeModelDelegate = HomeModel()
        
    //MARK: - Delegate Initializer
    required init(delegate: HomeViewControllerDelegate) {
        self.viewDelegate = delegate
    }
}

extension HomeViewModel: HomeViewModelDelegate {
    func getPlayers(completion: @escaping ([PlayerResponse]?, Error?) -> ()) {
        self.modelDelegate.getPlayers { (result, error) in
            guard error == nil else {
                print("error")
                return
            }
            completion(result, error)
        }
    }
}
