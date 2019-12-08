//
//  DataServiceController.swift
//  PlayersApp
//
//  Created by sergio blanco martin on 03/12/2019.
//  Copyright © 2019 sergio blanco martin. All rights reserved.
//

import Foundation
import Alamofire

class DataServiceController: NSObject {
    func decode<T>(_ type: T.Type, data: Data) throws -> T where T: Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    func getPlayers<T: Codable>(_ type: T.Type, completion: @escaping (_ data: T?, _ errorString: String?) -> ()) {
        let url = "https://api.myjson.com/bins/66851"
        
        Alamofire.request(url,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: nil).validate().responseData { response in
                            guard response.result.isSuccess else {
                                let error = response.error?.localizedDescription ?? ""
                                completion(nil, error)
                                return
                            }
                            
                            if (response.data != nil) {
                                do {
                                    let playerDetail : T = try self.decode(T.self, data: response.data!)
                                    completion(playerDetail, nil)
                                } catch {
                                    let error = response.error?.localizedDescription ?? ""
                                    print(error)

                                    completion(nil, error)
                                }
                            } else {
                                print ("DATA is nil")
                            }
        }
    }
}

