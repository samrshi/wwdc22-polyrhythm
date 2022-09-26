//
//  AudioEngine.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/19/22.
//

import AVFoundation
import UIKit

public class AudioEngine: NSObject, AVAudioPlayerDelegate {
    public static let shared = AudioEngine()

    private var players: [AVAudioPlayer] = []

    public func playSound(_ sound: Sound, volume: Double = 1) {
        do {
            let asset = sound.asset
            let player = try AVAudioPlayer(data: asset.data, fileTypeHint: asset.type)
            player.delegate = self
            player.numberOfLoops = 0
            player.play()
            player.setVolume(Float(volume), fadeDuration: 0)
            players.append(player)
        } catch {
            print("Couldn't play sound: \(sound.rawValue)")
        }
    }
    
    public func playSound(_ sound: Sound) {
        playSound(sound, volume: 1)
    }

    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        players.removeAll { audioPlayer in
            audioPlayer == player
        }
    }
}
