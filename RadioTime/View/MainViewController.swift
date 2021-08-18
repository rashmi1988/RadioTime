//
//  ViewController.swift
//  RadioTime
//
//  Created by Rashmi on 10/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UITabBarController, UITabBarControllerDelegate, MusicPlayerDelegate, AdProtocol {
    
    //MARK:- properties
    private var viewModel = SongsViewModel()
    private lazy var nowPlayingViewController = NowPlayingViewController()
    private lazy var recentlyPlayedSongsViewController = RecentlyPlayedSongsViewController()
    private let musicPlayerView = MusicPlayerView(frame: CGRect.zero)
    private var loader: UIActivityIndicatorView = {
        var tempLoader = UIActivityIndicatorView(style: .large)
        tempLoader.backgroundColor = .black
        tempLoader.color = .white
        tempLoader.hidesWhenStopped = true
        return tempLoader
    }()
    
    
    //MARK:- view life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupListeners()
        showLoader()
        viewModel.fetchSongs(isInitialDownload: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK:- callbacks to viewModel events
    func setupListeners() {
        // this will be called from viewmodel after initial download during app launch
        viewModel.updateUIAfterInitialDownloadSuccess = {
            self.view.isUserInteractionEnabled = true
            self.hideLoader()
            self.populateTabBarController()
            self.addPlayerView()
        }
        
        // this will be called from viewmodel after data refresh
        viewModel.updateUIAfterSongsRefreshed = {
            self.view.isUserInteractionEnabled = true
            self.hideLoader()
            if (self.viewModel.songsArray?.count ?? 0) > 0 {
                self.musicPlayerView.populateDataOnUI(aSong: self.viewModel.songsArray?[0])
                self.recentlyPlayedSongsViewController.refreshData(songsArray: self.viewModel.songsArray)
                self.nowPlayingViewController.refreshData(aSong: self.viewModel.songsArray?[0])
            }
        }
        
        // this will be called from viewmodel after any sort of download failure
        viewModel.showAlertAfterSongsDownloadFailed = { isInitialDownload in
            self.view.isUserInteractionEnabled = true
            self.hideLoader()
            // create the alert
            let alert = UIAlertController(title: "Error", message: "There was an error while fetching the latest songs, would like to retry?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { action in
                //if there is any download failure, re-try it with user confirmation
                // the boolean argument is to distinguish between initial sync and user refresh action
                self.showLoader()
                self.viewModel.fetchSongs(isInitialDownload: isInitialDownload)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

            // show the alert to user
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- UI setup methods
    func showLoader() {
        // Add the loader on view and start animating
        self.view.addSubview(loader)
        loader.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        loader.startAnimating()
    }
    func hideLoader() {
        // stop animating and remove the loader from view
        loader.stopAnimating()
        loader.removeFromSuperview()
    }
    
    func populateTabBarController()  {
        if let songsArray = viewModel.songsArray, songsArray.count>0 {
            nowPlayingViewController.songToHighlight = songsArray[0]
        }
        recentlyPlayedSongsViewController.songsArray = viewModel.songsArray
        
        // Create Tab one
        let tabNowPlaying = UINavigationController(rootViewController: nowPlayingViewController)
        nowPlayingViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(MainViewController.refreshData))
        let tabOneBarItem = UITabBarItem(title: "Now Playing", image: UIImage(systemName: "playpause"), selectedImage: UIImage(systemName: "playpause.fill"))
        tabNowPlaying.tabBarItem = tabOneBarItem
        
        // Create Tab two
        let tabRecentlyPlayed = UINavigationController(rootViewController: recentlyPlayedSongsViewController)
        let tabTwoBarItem2 = UITabBarItem(title: "Recently Played", image: UIImage(systemName: "clock"), selectedImage: UIImage(systemName: "clock.fill"))
        tabRecentlyPlayed.tabBarItem = tabTwoBarItem2
        
        // populate the view controllers
        self.viewControllers = [tabNowPlaying, tabRecentlyPlayed]
    }
    
    func addPlayerView()  {
        musicPlayerView.layer.cornerRadius = 5
        musicPlayerView.musicPlayerDelegate = self
        view.addSubview(musicPlayerView)
        musicPlayerView.translatesAutoresizingMaskIntoConstraints = false
        musicPlayerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(tabBar.snp.top).offset(-10)
            make.height.equalTo(100)
        }
        if (viewModel.songsArray?.count ?? 0) > 0 {
            musicPlayerView.populateDataOnUI(aSong: viewModel.songsArray?[0])
        }
    }
    
    //MARK:- data refresh on refresh button click
    @objc func refreshData(){
        // disable all user interactions while data is getting downloaded
        self.view.isUserInteractionEnabled = false
        showLoader()
        viewModel.fetchSongs(isInitialDownload: false)
    }
    
    
    //MARK:- custom delegate methods
    func showAdView() {
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "AdTimer")
        let adViewController = AdViewController()
        adViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: adViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func playSongAfterAd() {
        musicPlayerView.showPlayButtonIcon = false
        MusicPlayer.instance.play()
    }
    
    
    //MARK:-  deinit
    deinit {
        musicPlayerView.musicPlayerDelegate = nil
        musicPlayerView.removeFromSuperview()
    }
}

