//
//  NetworkClient.swift
//  RadioTime
//
//  Created by Rashmi on 13/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import Foundation
import Alamofire

class NetworkClient {
    private let songsURL = "https://api.itmwpb.com/nowplaying/v3/935/testapi"
    
    static func downloadSongs (completion: @escaping ([Song]?, Error?) -> Void) {
        AF.request("https://api.itmwpb.com/nowplaying/v3/935/testapi")
        .validate()
        .responseDecodable(of: [Song].self) { (response) in
            switch response.result {
            case let .success(songsArray):
                completion (songsArray, nil)
            case let .failure(error):
                completion (nil, error)
            }
        }
    }
}
