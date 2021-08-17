//
//  MusicPlayer.swift
//  RadioTime
//
//  Created by Rashmi on 17/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

// This singleton class is responsible for streaming music from the hard coded link
// It supports play and pause features

import Foundation
import AVFoundation

class MusicPlayer {
    public static var instance = MusicPlayer() // singletton instance
    private var player = AVPlayer()
    private let songURL = "https://rfcmedia.streamguys1.com/70hits.aac"
    
    func initialise() {
        guard let url = URL(string: songURL) else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        playAudioBackground()
    }
    
    func playAudioBackground() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
    }
    
    func pause(){
        print("music streaming paused")
        player.pause()
    }
    
    func play() {
        print("music streaming started")
        player.play()
    }
}
