//
//  SongsViewController.swift
//  WavePlayer
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class SongsViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        title = "Songs"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Now Playing", style: .plain, target: self, action: #selector(nowPlayingTapped))
    }
    
    @objc func nowPlayingTapped() {
        print("tapped")
    }
}

