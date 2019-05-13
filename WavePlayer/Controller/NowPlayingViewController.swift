//
//  NowPlayingViewController.swift
//  WavePlayer
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    let progress = Progress(totalUnitCount: 10)
    
    let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.tintColor = .red
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.font = label.font.withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Easily"
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.font = label.font.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bruno Major"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setImageCornerRadius()
        setPlayPauseButtonCornerRadius()
    }
    
    func setImageCornerRadius() {
        albumImageView.layer.cornerRadius = albumImageView.frame.width/2
        albumImageView.layer.masksToBounds = true
        albumImageView.clipsToBounds = true
    }
    
    func setPlayPauseButtonCornerRadius() {
        playPauseButton.layer.cornerRadius = playPauseButton.frame.width/2
        playPauseButton.layer.masksToBounds = true
        playPauseButton.clipsToBounds = true
    }
    
    func setupViews() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        setupBackButton()
        setupAlbumImageView()
        setupProgressView()
        setupPlayPauseButton()
        setupPreviousButton()
        setupNextButton()
        setupTitleAndArtistLabel()
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    func setupAlbumImageView() {
        view.addSubview(albumImageView)
        albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
    }
    
    func setupProgressView() {
        view.addSubview(progressView)
        progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 30).isActive = true
        progressView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        progressView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func setupPlayPauseButton() {
        view.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playPauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupPreviousButton() {
        view.addSubview(previousButton)
        previousButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        previousButton.rightAnchor.constraint(equalTo: playPauseButton.leftAnchor, constant: -70).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        nextButton.leftAnchor.constraint(equalTo: playPauseButton.rightAnchor, constant: 70).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupTitleAndArtistLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: playPauseButton.topAnchor, constant: -70).isActive = true
        
        view.addSubview(artistLabel)
        artistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func backButtonTapped() {
        //
    }
    
    @objc func previousButtonTapped() {
        
    }
    
    @objc func playPauseButtonTapped() {
        // 1
        progressView.progress = 0.0
        progress.completedUnitCount = 0
        
        // 2
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            guard self.progress.isFinished == false else {
                timer.invalidate()
                return
            }
            
            // 3
            self.progress.completedUnitCount += 1
            self.progressView.setProgress(Float(self.progress.fractionCompleted), animated: true)
        }
    }
    
    @objc func nextButtonTapped() {
        
    }
}
