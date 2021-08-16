//
//  RecentlyPlayedSongsTableViewCell.swift
//  RadioTime
//
//  Created by Rashmi on 13/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class RecentlyPlayedSongsTableViewCell: UITableViewCell {

    private let lblSongTitle = UILabel()
    private let lblArtistName = UILabel()
    
     private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 100
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    // Add a horizontal stack view for song title and artist name
     private let titleStackView : UIStackView = {
        let innerStackView = UIStackView()
        //innerStackView.backgroundColor = .green
        innerStackView.axis = .vertical
        innerStackView.spacing = 5.0
        innerStackView.alignment = .fill
        innerStackView.distribution = .fill
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        return innerStackView
    }()
    
    // Image view for album art
     private let imgAlbumArt : UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.contentMode = .scaleAspectFit
        return tempImageView
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        lblSongTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lblSongTitle.numberOfLines = 0
        lblArtistName.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        [lblSongTitle, lblArtistName].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        imgAlbumArt.setContentHuggingPriority(.defaultLow, for: .horizontal)
        lblSongTitle.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        lblArtistName.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        [imgAlbumArt, titleStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        self.addSubview(separatorView)
        
        stackView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(contentView)
            make.bottom.equalTo(separatorView.snp.top)
        }
        separatorView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(contentView)
        }
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(5)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureCell(aSong song: Song?){
        if let song = song {
            if let url = song.image_url {
                imageView?.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "placeholder"))
            }
            lblSongTitle.text = song.name
            lblArtistName.text = song.artist
        }
    }

}
