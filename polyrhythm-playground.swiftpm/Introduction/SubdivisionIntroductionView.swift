//
//  SubdivisionIntroductionView.swift
//
//
//  Created by Samuel Shi on 4/24/22.
//

import SwiftUI

struct SubdivisionIntroductionView: View {
    @State private var showLines: Bool = false
    @StateObject private var metronomeManager = PolyrhythmManager(baseTempo: 120, rhythms: [.four])

    var body: some View {
        HStack(spacing: 24) {
            VStack(alignment: .leading, spacing: 24) {
                Text("Before we learn about polyrhythms, we will need a brief introduction to musical rhythm!")

                Text("This sheet music is one **measure** of 4/4, meaning that the music is grouped together into collections of 4 evenly divided **beats**.")
                    + Text(" Tap on the pink ")
                    + Text(Image(systemName: "play.fill"))
                    + Text(" Play button to see this division take place and hear how it sounds!")

                Button {
                    togglePlaying()
                } label: {
                    Label(showLines ? "Stop" : "Play", systemImage: showLines ? "stop.fill" : "play.fill")
                        .animation(.none, value: showLines)
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)
                
                Text("This process of taking some amount of time and equally dividing it is called **subdivision**. Let's learn about how subdivision relates to polyrhythms!")

                NavigationLink {
                    PolyrhythmIntroductionView()
                } label: {
                    Text("Learn More!!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }

            VStack(spacing: 24) {
                Image("4-4")
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        Image("4-4-lines")
                            .resizable()
                            .scaledToFit()
                            .mask {
                                GeometryReader { proxy in
                                    Rectangle()
                                        .offset(x: 0, y: showLines ? 0 : -proxy.size.height)
                                }
                            }
                    }

                if showLines {
                    PolyrhythmView(manager: metronomeManager, showRhythmActions: false)
                        .frame(height: 100)
                        .transition(.scale)
                }
            }
        }
        .animation(.default, value: showLines)
        .padding()
        .font(.title2)
        .navigationTitle("🤷 What are polyrhythms?!")
        .onDisappear {
            showLines = false
            metronomeManager.stop()
        }
    }

    func togglePlaying() {
        showLines.toggle()

        if showLines {
            metronomeManager.start()
        } else {
            metronomeManager.stop()
        }
    }
}

struct SubdivisionIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SubdivisionIntroductionView()
        }
        .navigationViewStyle(.stack)
        .previewInterfaceOrientation(.landscapeRight)
    }
}
