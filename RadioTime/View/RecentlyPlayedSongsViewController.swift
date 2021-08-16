//
//  RecentlyPlayedViewController.swift
//  RadioTime
//
//  Created by Rashmi on 10/08/21.
//  Copyright © 2021 InterTechMedia. All rights reserved.
//

import UIKit
import SnapKit

class RecentlyPlayedSongsViewController: UIViewController, UITableViewDataSource {
    
    var songsArray: [Song]?
    private var recentlyPlayedSongsTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recentlyPlayedSongsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecentlyPlayedSongsTableViewCell
        recentlyPlayedSongsTableViewCell.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 255.0/255.0, alpha: 0.5)
        recentlyPlayedSongsTableViewCell.preservesSuperviewLayoutMargins = false
        recentlyPlayedSongsTableViewCell.separatorInset = UIEdgeInsets.zero
        recentlyPlayedSongsTableViewCell.layoutMargins = UIEdgeInsets.zero
        recentlyPlayedSongsTableViewCell.configureCell(aSong: songsArray?[indexPath.row])
        return recentlyPlayedSongsTableViewCell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Recently Played Songs"
        
        recentlyPlayedSongsTableView = UITableView()
        recentlyPlayedSongsTableView.separatorColor = .white
        recentlyPlayedSongsTableView.register(RecentlyPlayedSongsTableViewCell.self, forCellReuseIdentifier: "cell")

        recentlyPlayedSongsTableView.dataSource = self

        recentlyPlayedSongsTableView.rowHeight = 75

        self.view.addSubview(recentlyPlayedSongsTableView)
        recentlyPlayedSongsTableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-200)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        recentlyPlayedSongsTableView.reloadData()
    }
    
    func refreshData(songsArray: [Song]?) {
        self.songsArray = songsArray
        recentlyPlayedSongsTableView.reloadData()
    }
}
