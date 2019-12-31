//
//  ViewController.swift
//  WavePlayer
//
//  Created by admin on 12/29/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation

class ViewController: UIViewController, SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!
    var player: SPTAudioStreamingController?
    var loginURL: URL?
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Login"
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuth()
        setupObservers()
        setupLoginButton()
        view.backgroundColor = .white
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector:  #selector(updateAfterFirstLogin), name: NSNotification.Name(rawValue: "loginSuccessful"), object: nil)
    }
    
    func setupAuth() {
        let redirectURL = "WavePlayer://returnAfterLogin"
        let clientID = "76d40d63a9174d368c0808be8ac410cf"
        auth.redirectURL = URL(string: redirectURL)
        auth.clientID = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginURL = auth.spotifyAppAuthenticationURL()
    }
    
    func initalizePlayer(authSession: SPTSession) {
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player?.playbackDelegate = self
            self.player?.delegate = self
            try! player?.start(withClientId: auth.clientID)
            self.player?.login(withAccessToken: authSession.accessToken)
        }
    }
    
    @objc func updateAfterFirstLogin() {
        let userDefaults = UserDefaults.standard
        if let sessionObject:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObject = sessionObject as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObject) as! SPTSession
            self.session = firstTimeSession
            initalizePlayer(authSession:  session)
        }
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        print("logged in")
    }
    
    @objc func loginTapped() {
        if let url = loginURL {
            UIApplication.shared.open(url)
        }
    }
}

