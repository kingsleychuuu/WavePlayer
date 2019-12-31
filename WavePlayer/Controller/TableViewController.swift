//
//  TableViewController.swift
//  WavePlayer
//
//  Created by admin on 12/30/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var songs = [Song]()
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Library"
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellID)
        setupSongs()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell
        cell.textLabel?.text = songs[indexPath.row].title
        cell.detailTextLabel?.text = "\(songs[indexPath.row].artist) - \(songs[indexPath.row].album)"
        cell.imageView?.image = UIImage(named: songs[indexPath.row].albumArtURL)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = PlayerViewController()
        viewController.songs = songs
        viewController.currentSong = songs[indexPath.row]
        present(viewController, animated: true, completion: nil)
    }

    func setupSongs() {
        let noGuidance = Song(title: "No Guidance ft. Drake",
                              artist: "Chris Brown",
                              album: "Indigo",
                              albumArtURL: "NoGuidance.png",
                              audioURL: "NoGuidance.mp3")
        let uGotThat = Song(title: "U Got That",
                            artist: "Halogen",
                            album: "U Got That",
                            albumArtURL: "UGotThat.png",
                            audioURL: "UGotThat.mp3")
        let allMyFriends = Song(title: "All My Friends",
                                artist: "Madeon",
                                album: "Good Faith",
                                albumArtURL: "GoodFaith.png",
                                audioURL: "AllMyFriends.mp3")
        let serendipity = Song(title: "Serendipity",
                               artist: "BTS",
                               album: "Love Yourself",
                               albumArtURL: "LoveYourself.png",
                               audioURL: "Serendipity.mp3")
        let home = Song(title: "Home",
                        artist: "Bruno Major",
                        album: "A Song For Every Moon",
                        albumArtURL: "ASFEV.png",
                        audioURL: "Home.mp3")
        
        songs = [serendipity, uGotThat, allMyFriends, home, noGuidance]
        
    }
}
