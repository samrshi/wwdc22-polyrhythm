//
//  PolyrhythmSolidificationView.swift
//  
//
//  Created by Samuel Shi on 4/25/22.
//

import SwiftUI

struct PolyrhythmSolidificationView: View {
    @StateObject private var manager = PolyrhythmManager(baseTempo: 90, rhythms: [.four, .three])
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Let's take a look at another polyrhythm! This is known as a 4/3 polyrhythm since we are overlaying a four note subdivision over a three note subdivision. Let's take a look!! This time, try pressing the ")
                + Text(Image(systemName: "headphones"))
                + Text(" buttons to focus on each subdivision on at a time. This will help you understand how each rhythm plays into the polyrhythm as a whole!")
            
            Text("Now that you have some experience with polyrhythms, let's go to the Polyrhythm Playground to get more practice understanding and visualizing **polyrhythms**!!")

            Spacer()
            
            HStack {
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
                
                Spacer()

                NavigationLink {
                    PolyrhythmPlayground()
                } label: {
                    Text("Let's Play!!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            Spacer()

            Image("4-3")
                .resizable()
                .scaledToFit()

            Spacer()
            
            PolyrhythmView(manager: manager, showRhythmActions: true)
        }
        .font(.title2)
        .padding()
        .onDisappear {
            manager.stop()
        }
        .navigationBarTitle("4/3 Polyrhythm")
    }

    func togglePlaying() {
        if manager.isPlaying {
            manager.stop()
        } else {
            manager.start()
        }
    }
}

struct PolyrhythmSolidificationView_Previews: PreviewProvider {
    static var previews: some View {
        PolyrhythmSolidificationView()
    }
}
