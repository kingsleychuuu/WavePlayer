//
//  PlaylistsViewController.swift
//  WavePlayer
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class PlaylistsViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()

    }
    

    func setupNavBar() {
        title = "Playlists"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Now Playing", style: .plain, target: self, action: #selector(nowPlayingTapped))
    }
    
    @objc func nowPlayingTapped() {
        let nowPlayingViewController = NowPlayingViewController()
        present(nowPlayingViewController, animated: true)
    }
}
