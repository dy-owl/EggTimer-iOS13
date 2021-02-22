//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime: Float = 0.0
    var secondsPassed: Float = 0.0
    
    var timer = Timer()
    var player = AVAudioPlayer()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0.0
        
        let hardness = sender.currentTitle!
        titleLabel.text = hardness
        totalTime = Float(eggTimes[hardness]!)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = secondsPassed / totalTime
            print(progressBar.progress)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound(soundName: "alarm_sound", soundExtension: "mp3")
        }
    }
    
    func playSound(soundName: String, soundExtension: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: soundExtension)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
