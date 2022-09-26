//
//  PolyrhythmIntroductionView.swift
//
//
//  Created by Samuel Shi on 4/25/22.
//

import SwiftUI

struct PolyrhythmIntroductionView: View {
    @StateObject private var manager = PolyrhythmManager(baseTempo: 120, rhythms: [.three, .two])
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Now that you know a little bit about subdivisions, we can talk more about polyrhythms. A **polyrhythm** occurs when you play multiple subdivisions at the same time. In the sheet music below, you'll notice that we have combined two different subvisions of one beat.")

            Text("There are four beats, and each is equally subdivided into both groups of three and groups of two. This is called a 3/2 polyrhythm (read \"3 over 2\")")

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
                    PolyrhythmSolidificationView()
                } label: {
                    Text("More Polyrhythms!!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }

            Image("3-2")
                .resizable()
                .scaledToFit()

            PolyrhythmView(manager: manager, showRhythmActions: true)
        }
        .font(.title2)
        .padding()
        .onDisappear {
            manager.stop()
        }
        .navigationBarTitle("3/2 Polyrhythm")
    }

    func togglePlaying() {
        if manager.isPlaying {
            manager.stop()
        } else {
            manager.start()
        }
    }
}

struct PolyrhythmIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        PolyrhythmIntroductionView()
    }
}
