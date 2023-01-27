//
//  ViewController.swift
//  EggTimer
//
//  Created by Дмитрий on 25.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var textLabel: UILabel!
    
    let eggTime = ["Soft": 300.0, "Medium": 420.0, "Hard": 720.0]
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBAction func eggPressedButtom(_ sender: UIButton) {
        textLabel.text = "How do you like your eggs?"
        progressBar.progress = 0
        timer.invalidate()
        
        guard let hardness = sender.currentTitle else { return }
        guard var time = eggTime[hardness] else { return }
        let time100 = time
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            if time > 0 {
                print(time)
                time -= 1
                self.progressBar.progress = 1.0 - Float(time)/Float(time100)
            } else {
                self.timer.invalidate()
                self.textLabel.text = "DONE!"
                self.playSound()
            }
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
        
}

