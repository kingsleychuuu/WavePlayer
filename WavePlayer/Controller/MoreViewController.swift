//
//  MoreViewController.swift
//  WavePlayer
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        registerCell()
    }
    
    func registerCell() {
        tableView.register(MoreTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func setupNavBar() {
        title = "More"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(nowPlayingTapped))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MoreTableViewCell
        cell.backgroundColor = .green
        return cell
    }
    
    @objc func nowPlayingTapped() {
        print("tapped")
    }
}
