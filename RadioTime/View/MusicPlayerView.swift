//
//  MusicPlayerView.swift
//  RadioTime
//
//  Created by Rashmi on 10/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation

class MusicPlayerView: UIView {
    
    private var showPlayButtonIcon = true
    private var player: AVPlayer?
    private let lblSongTitle = UILabel()
    private let lblArtistName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func layoutSubviews() {
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self)
        }
        backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    // Button to play/pause live radio stream
    private let btnPlayPause: UIButton = {
        let tempButton = UIButton ()
        tempButton.setImage(UIImage(named: "play"), for: .normal)
        tempButton.addTarget(self, action: #selector(MusicPlayerView.onPlayPauseButtonTap(_:)), for: .touchUpInside)
        return tempButton
    }()
    
    // Add a horizontal stack view for song title and artist name
    private let titleStackView : UIStackView = {
        let innerStackView = UIStackView()
        innerStackView.backgroundColor = .green
        innerStackView.axis = .vertical
        innerStackView.spacing = 5.0
        innerStackView.alignment = .fill
        innerStackView.distribution = .fillEqually
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        return innerStackView
    }()
    
    // Image view for album art
    private let artImageView : UIImageView = {
        let tempImageView = UIImageView(image: UIImage(named: "placeholder"))
        tempImageView.contentMode = .scaleAspectFit
        return tempImageView
    }()
    
    func setupView() {
        lblSongTitle.text = "Default Song title"
        lblSongTitle.numberOfLines = 0
        lblSongTitle.font = UIFont.systemFont(ofSize: 18)
        lblArtistName.text = "Artist Name"
        lblArtistName.numberOfLines = 0
        lblArtistName.font = UIFont.italicSystemFont(ofSize: 14)
        [lblSongTitle, lblArtistName].forEach {
            titleStackView.addArrangedSubview($0)
        }
        [artImageView, titleStackView, btnPlayPause].forEach {
            stackView.addArrangedSubview($0)
        }
        addSubview(stackView)
    }
    
    @objc func onPlayPauseButtonTap (_ sender: Any) {
        
        if showPlayButtonIcon {
            loadRadio(radioURL: "https://rfcmedia.streamguys1.com/70hits.aac")
        }
        showPlayButtonIcon = !showPlayButtonIcon
        
        if !showPlayButtonIcon {
            self.btnPlayPause.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            self.btnPlayPause.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    func loadRadio(radioURL: String) {

        guard let url = URL(string: radioURL) else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    func populateDataOnUI(aSong song: Song?){
        if let song = song {
            if let url = song.image_url {
                artImageView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "placeholder"))
            }
            lblSongTitle.text = song.name
            lblArtistName.text = song.artist
        }
    }
}
