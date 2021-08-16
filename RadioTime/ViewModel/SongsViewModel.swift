//
//  SongsViewModel.swift
//  RadioTime
//
//  Created by Rashmi on 13/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import Foundation

class SongsViewModel {
    
    var songsArray: [Song]?
    
    // MARK: - Closures for callback, to control the view from viewmodel
    var showAlertAfterSongsDownloadFailed: ((_ isInitialDownload: Bool) -> ())?
    var updateUIAfterInitialDownloadSuccess: (() -> ())?
    var updateUIAfterSongsRefreshed: (() -> ())?
    
    // MARK: - Network call
    func fetchSongs(isInitialDownload: Bool) {
        NetworkClient.downloadSongs { (songsArray, error) in
            if error != nil {
                print("song download error")
                self.showAlertAfterSongsDownloadFailed? (isInitialDownload)
            } else if songsArray != nil {
                print("song download success")
                self.songsArray = songsArray!
                if isInitialDownload {
                    self.updateUIAfterInitialDownloadSuccess? ()
                } else {
                    self.updateUIAfterSongsRefreshed? ()
                }
            }
        }
    }
}
