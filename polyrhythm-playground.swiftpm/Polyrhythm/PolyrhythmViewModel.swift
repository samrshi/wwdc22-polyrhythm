//
//  PolyrhythmViewModel.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/19/22.
//

import Combine
import Foundation

class PolyrhythmManager: ObservableObject {
    @Published public var mutableBaseTempo: Int
    @Published public var baseTempo: Int
    
    @Published public var mutableRhythms: [Rhythm]
    @Published public var rhythms: [Rhythm]
    
    @Published private var timerCancellables: [AnyCancellable] = []
    
    init() {
        self.mutableBaseTempo = 60
        self.baseTempo = 60
        
        self.mutableRhythms = Rhythm.defaults
        self.rhythms = Rhythm.defaults
    }
    
    init(baseTempo: Int, rhythms: [Rhythm]) {
        self.mutableBaseTempo = baseTempo
        self.baseTempo = baseTempo
        
        self.mutableRhythms = rhythms
        self.rhythms = rhythms
    }
}

// MARK: External Play/Stop functions and properties

extension PolyrhythmManager {
    public func start() {
        startRhythmTimers(tempo: baseTempo, counts: mutableRhythms.map(\.count))
    }
    
    public func stop() {
        timerCancellables = []
    }
    
    public var isPlaying: Bool {
        !timerCancellables.isEmpty
    }
}

// MARK: Metronome Timer Logic

extension PolyrhythmManager {
    private func startRhythmTimers(tempo: Int, counts: [Int]) {
        guard let baseCount = counts.last else { return }
        
        rhythms = rhythms.replaceEach(at: \.selected, with: 0)
        
        let playingSounds = rhythms.filter { $0.isPlaying }.map(\.sound)
        playingSounds.forEach(AudioEngine.shared.playSound)
        
        timerCancellables = []
        
        for (index, rhythm) in rhythms.enumerated() {
            let rhythmTempo = rhythm.tempo(baseTempo: tempo, baseCount: baseCount, isBase: index == rhythms.endIndex)
            
            Timer.publish(every: 60.0 / rhythmTempo, on: .main, in: .common).autoconnect()
                .receive(on: DispatchQueue.main)
                .map { _ in index }
                .sink(receiveValue: handleRhythmTimerEvent)
                .store(in: &timerCancellables)
        }
    }
    
    private func handleRhythmTimerEvent(index: Int) {
        guard let rhythm = rhythms[safe: index] else { return }
        
        let allRhythmsAreDone = rhythms.allSatisfy { $0.selected == $0.count - 1 }
        let rhythmCountsHaveChanged = mutableRhythms.map(\.count) != rhythms.map(\.count)
        let tempoHasChanged = mutableBaseTempo != baseTempo
        
        if allRhythmsAreDone, rhythmCountsHaveChanged || tempoHasChanged {
            rhythms = mutableRhythms
            startRhythmTimers(tempo: baseTempo, counts: mutableRhythms.map(\.count))
            return
        }
        
        rhythms[safe: index]?.selected = (rhythm.selected + 1) % rhythm.count
        if rhythm.isPlaying { AudioEngine.shared.playSound(rhythm.sound, volume: rhythm.volume) }
    }
}

// MARK: Handle View Events

extension PolyrhythmManager {
    func handleRhythmAction(action: RhythmAction, index: Int) {
        if action == .focus {
            toggleFocus(onIndex: index)
        }
    }
    
    func toggleFocus(onIndex index: Int) {
        if rhythmIsFocused(index: index) {
            rhythms = rhythms.replaceEach(at: \.volume, with: 1)
        } else {
            for i in rhythms.indices {
                rhythms[safe: i]?.volume = i == index ? 1 : 0.25
            }
        }
    }
    
    func rhythmIsFocused(index: Int) -> Bool {
        guard let rhythm = rhythms[safe: index], rhythm.isPlaying else { return false }
        
        for (i, rhythm) in rhythms.enumerated() {
            if i != index, rhythm.volume == 1 {
                return false
            }
        }
        
        return true
    }
}
