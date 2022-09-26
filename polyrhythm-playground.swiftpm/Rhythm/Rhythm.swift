//
//  Rhythm.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/20/22.
//

import SwiftUI

struct Rhythm: Identifiable, Hashable {
    let id = UUID()

    var count: Int
    var selected: Int = 0
    var isPlaying: Bool
    var color: Color
    var sound: Sound
    var volume: Double = 1

    func tempo(baseTempo: Int, baseCount: Int, isBase: Bool) -> Double {
        isBase ? Double(baseTempo) : Double(count) * Double(baseTempo) / Double(baseCount)
    }
}

extension Rhythm {
    static var four: Rhythm {
        Rhythm(count: 4, isPlaying: true, color: .pink, sound: .lowClap)
    }

    static var five: Rhythm {
        Rhythm(count: 3, isPlaying: true, color: .blue, sound: .highClap)
    }

    static var three: Rhythm {
        Rhythm(count: 3, isPlaying: true, color: .blue, sound: .highClap)
    }

    static var two: Rhythm {
        Rhythm(count: 2, isPlaying: true, color: .purple, sound: .lowClap)
    }

    static var defaults: [Rhythm] {
        [.five, .two]
    }
}
