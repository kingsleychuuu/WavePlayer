//
//  Song.swift
//  WavePlayer
//
//  Created by admin on 12/30/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import Foundation

class Song: NSObject, Codable {
    internal init(title: String, artist: String, album: String, albumArtURL: String, audioURL: String) {
        self.title = title
        self.artist = artist
        self.album = album
        self.albumArtURL = albumArtURL
        self.audioURL = audioURL
    }
    
    var title: String
    var artist: String
    var album: String
    var albumArtURL: String
    var audioURL: String
    
}
