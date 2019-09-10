//
//  NowPlayingViewController.swift
//  WavePlayer
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let playPauseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.font = label.font.withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Easily"
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.font = label.font.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bruno Major"
        return label
    }()
    
    let shapeLayer = CAShapeLayer()
    
    let pathLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setImageCornerRadius()
        setPlayPauseButtonCornerRadius()
        setupShapeLayer()
        setupWave()
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
        tabBarController?.tabBar.isHidden = true
        setupAlbumImageView()
        setupPlayPauseButton()
        setupPreviousButton()
        setupNextButton()
        setupTitleAndArtistLabel()
    }
    
    func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    func setupAlbumImageView() {
        view.addSubview(albumImageView)
        albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
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
    
    func setupShapeLayer() {
        let circularPath = UIBezierPath(arcCenter: albumImageView.center, radius: (view.frame.width/4) + 10, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.init(white: 0.9, alpha: 1).cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shapeLayer)
    }
    
    func setupWave() {
        let centerY = view.frame.height / 2  // find the vertical center
        let steps = 100                 // Divide the curve into steps
        let stepX = view.frame.width / CGFloat(steps) // find the horizontal step distance
        // Make a path
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: centerY))
        // Loop and draw steps in straingt line segments
        for i in 0...steps {
            let x = CGFloat(i) * stepX
            let y = (sin(Double(i) * 0.1) * 70) + Double(centerY)
            path.addLine(to: CGPoint(x: x, y: CGFloat(y)))
        }
        
        pathLayer.path = path.cgPath
        pathLayer.lineWidth = 3
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.strokeStart = 0
        pathLayer.strokeEnd = 1 // <<
        view.layer.addSublayer(pathLayer)
    }
    
    @objc func backButtonTapped() {
        
    }
    
    @objc func previousButtonTapped() {
        
    }
    
    @objc func playPauseButtonTapped() {
        
    }
    
    @objc func nextButtonTapped() {
        
    }
    
    @objc func handleTap() {
        print("tapped")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "strokeEnd")
        /*
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        animation.isRemovedOnCompletion = true
        pathLayer.add(animation, forKey: "strokeEnd")
 */
    }
}
