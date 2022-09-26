//
//  PolyrhythmPlayground.swift
//  polyrhythm-explorer
//
//  Created by Samuel Shi on 4/22/22.
//

import SwiftUI

struct PolyrhythmPlayground: View {
    @StateObject private var manager = PolyrhythmManager()
    
    var body: some View {
        VStack {
            HStack {
                Text("Base Tempo: \(manager.baseTempo) bpm")
                IntSlider(value: $manager.baseTempo, range: 30 ... 70)
            }

            HStack {
                ForEach($manager.mutableRhythms) { $rhythm in
                    PolyrhythmPicker(rhythmCount: $rhythm.count, range: 2 ... 9)
                }
            }
            
            Button {
                togglePlaying()
            } label: {
                Label(manager.isPlaying ? "Stop" : "Play", systemImage: manager.isPlaying ? "stop.fill" : "play.fill")
                    .animation(.none, value: manager.isPlaying)
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(10)
            }
            
            PolyrhythmView(manager: manager, showRhythmActions: true)
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                manager.start()
            }
        }
        .onDisappear {
            manager.stop()
        }
        .navigationTitle("Polyrhythm Playground")
    }
    
    func togglePlaying() {
        if manager.isPlaying {
            manager.stop()
        } else {
            manager.stop()
        }
    }
}
