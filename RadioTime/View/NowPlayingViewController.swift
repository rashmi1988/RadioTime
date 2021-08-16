//
//  NowPlayingViewController.swift
//  RadioTime
//
//  Created by Rashmi on 10/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class NowPlayingViewController: UIViewController {
    
    var songToHighlight: Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Now Playing"
        self.setupView()
    }
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let lblSongTitle = UILabel()
    private let lblArtistName = UILabel()
    
    // Add a horizontal stack view for song title and artist name
    private let titleStackView : UIStackView = {
        let innerStackView = UIStackView()
        innerStackView.backgroundColor = .green
        innerStackView.axis = .vertical
        innerStackView.spacing = 10.0
        innerStackView.alignment = .center
        innerStackView.distribution = .fill
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
        if let imageURL = self.songToHighlight?.image_url {
            artImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "placeholder"))
            
        }
        lblSongTitle.text = songToHighlight?.name ?? "Default song title"
        lblSongTitle.font = UIFont.boldSystemFont(ofSize: 30)
        lblSongTitle.numberOfLines = 0
        lblArtistName.text = songToHighlight?.artist ?? "Default artist name"
        lblArtistName.font = UIFont.italicSystemFont(ofSize: 20)
        [lblSongTitle, lblArtistName].forEach {
            titleStackView.addArrangedSubview($0)
        }
        [artImageView, titleStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-250)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
        }
    }
    
    func refreshData(aSong: Song?) {
        songToHighlight = aSong
        if let imageURL = self.songToHighlight?.image_url {
            artImageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "placeholder"))
                    }
        lblSongTitle.text = songToHighlight?.name ?? "Default song title"
        lblArtistName.text = songToHighlight?.artist ?? "Default artist name"
    }
}
