//
//  NowPlayingViewController.swift
//  WavePlayer
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Kingsley. All rights reserved.
//

import UIKit
import AVFoundation

class NowPlayingViewController: UIViewController {
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LoveYourself.png")
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let playPauseButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.setImage(UIImage(named: "play.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let previousButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.setImage(UIImage(named: "previous.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.setImage(UIImage(named: "next.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 10
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = label.font.withSize(40)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Serendipity"
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = .zero
        label.layer.shadowRadius = 10
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BTS"
        return label
    }()
    
    let highWaveShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 3
        return layer
    }()
    
    let mediumWaveShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 3
        return layer
    }()
    
    let lowWaveShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 3
        return layer
    }()
    
    var displayLink: CADisplayLink?
    var startTime: CFAbsoluteTime?
    let scrubbingShapeLayer = CAShapeLayer()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAudioPlayer()
        setupWaveLayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setImageCornerRadius()
        setupScrubbingShapeLayer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopDisplayLink()
    }
    
    func setupAudioPlayer() {
        let audioFile = Bundle.main.path(forResource: "serendipity", ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioFile!))
            audioPlayer.isMeteringEnabled = true
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [AVAudioSession.CategoryOptions.mixWithOthers])
        } catch {
            print(error)
        }
        audioPlayer.pause()
    }
    
    func setImageCornerRadius() {
        albumImageView.layer.cornerRadius = albumImageView.frame.width/2
        albumImageView.layer.masksToBounds = true
        albumImageView.clipsToBounds = true
    }
    
    func setupViews() {
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        setupAlbumImageViewConstraints()
        setupPlayPauseButtonConstraints()
        setupPreviousButtonConstraints()
        setupNextButtonConstraints()
        setupTitleAndArtistLabelConstraints()
    }
    
    func setupAlbumImageViewConstraints() {
        view.addSubview(albumImageView)
        albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        albumImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: view.frame.width/1.5).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant: view.frame.width/1.5).isActive = true
    }
    
    func setupPlayPauseButtonConstraints() {
        view.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playPauseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupPreviousButtonConstraints() {
        view.addSubview(previousButton)
        previousButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        previousButton.rightAnchor.constraint(equalTo: playPauseButton.leftAnchor, constant: -50).isActive = true
        previousButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        previousButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupNextButtonConstraints() {
        view.addSubview(nextButton)
        nextButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        nextButton.leftAnchor.constraint(equalTo: playPauseButton.rightAnchor, constant: 50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupTitleAndArtistLabelConstraints() {
        view.addSubview(artistLabel)
        artistLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artistLabel.bottomAnchor.constraint(equalTo: playPauseButton.topAnchor, constant: -50).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: artistLabel.topAnchor, constant: -10).isActive = true
    }
    
    func setupScrubbingShapeLayer() {
        let circularPath = UIBezierPath(arcCenter: albumImageView.center, radius: (view.frame.width/3) + 10, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.init(white: 0.9, alpha: 1).cgColor
        trackLayer.lineWidth = 5
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        scrubbingShapeLayer.path = circularPath.cgPath
        scrubbingShapeLayer.strokeColor = albumImageView.image?.averageColor?.cgColor
        scrubbingShapeLayer.lineWidth = 5
        scrubbingShapeLayer.lineCap = CAShapeLayerLineCap.round
        scrubbingShapeLayer.strokeEnd = 0
        scrubbingShapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(scrubbingShapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = audioPlayer.duration
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        scrubbingShapeLayer.add(basicAnimation, forKey: "strokeEnd")
        pauseAnimation(layer: scrubbingShapeLayer)
    }
    
    func setupWaveLayer() {
        view.layer.insertSublayer(highWaveShapeLayer, at: 0)
        view.layer.insertSublayer(mediumWaveShapeLayer, at: 0)
        view.layer.insertSublayer(lowWaveShapeLayer, at: 0)
        let averageColor = albumImageView.image?.averageColor?.withAlphaComponent(0.5).cgColor
        highWaveShapeLayer.fillColor = averageColor
        mediumWaveShapeLayer.fillColor = averageColor
        lowWaveShapeLayer.fillColor = averageColor
        startDisplayLink()
    }
    
    func startDisplayLink() {
        startTime = CFAbsoluteTimeGetCurrent()
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector:#selector(handleDisplayLink(_:)))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc func handleInitialDisplayLink(_ displayLink: CADisplayLink) {
        
    }
    
    @objc func handleDisplayLink(_ displayLink: CADisplayLink) {
        let elapsed = CFAbsoluteTimeGetCurrent() - startTime!
        audioPlayer.updateMeters()
        let db = audioPlayer.averagePower(forChannel: 0)
        let power = CGFloat(pow(10.0, db / 20.0) * 70.0)
        highWaveShapeLayer.path = wave(changeRate: elapsed, peaks: 3, amplitude: power).cgPath
        mediumWaveShapeLayer.path = wave(changeRate: elapsed/1.5, peaks: 2, amplitude: power).cgPath
        lowWaveShapeLayer.path = wave(changeRate: elapsed/2, peaks: 1.5, amplitude: power).cgPath
    }
    
    func wave(changeRate: Double, peaks: Double, amplitude: CGFloat) -> UIBezierPath {
        let centerY = view.bounds.height / 2 + 50
        func f(_ x: Int) -> CGFloat {
            return sin(((CGFloat(x) / view.bounds.width) + CGFloat(changeRate)) * CGFloat(peaks) * .pi) * amplitude + centerY
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: f(0)))
        for x in stride(from: 0, to: Int(view.bounds.width + 9), by: 10) {
            path.addLine(to: CGPoint(x: CGFloat(x), y: f(x)))
        }
        path.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: view.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: f(0)))
        
        return path
    }
    
    @objc func backButtonTapped() {
        
    }
    
    @objc func previousButtonTapped() {
        
    }
    
    @objc func playPauseButtonTapped() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            pauseAnimation(layer: scrubbingShapeLayer)
            displayLink?.isPaused = true
            playPauseButton.setImage(UIImage(named: "play.png"), for: .normal)
        } else {
            audioPlayer.play()
            resumeAnimation(layer: scrubbingShapeLayer)
            displayLink?.isPaused = false
            playPauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
        }
    }
    
    @objc func nextButtonTapped() {
        audioPlayer.updateMeters()
        let db = audioPlayer.averagePower(forChannel: 0)
        let power = pow(10.0, db / 20.0) * 30.0
        print(power)
    }
    
    func pauseAnimation(layer: CAShapeLayer){
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeAnimation(layer: CAShapeLayer){
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}
