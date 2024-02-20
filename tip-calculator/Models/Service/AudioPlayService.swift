//
//  AudioPlayService.swift
//  tip-calculator
//
//  Created by SENGHORT KHEANG on 1/15/24.
//

import Foundation
import AVFoundation

protocol AudioPlayService {
    func playSound()
}

class MockAudioPlayService: AudioPlayService {
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "wav")!
        let url = URL(filePath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
