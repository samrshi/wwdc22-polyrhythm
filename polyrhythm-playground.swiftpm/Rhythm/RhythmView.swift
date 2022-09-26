//
//  RhythmView.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/19/22.
//

import Combine
import SwiftUI

struct RhythmView: View {
    let rhythm: Rhythm
    let index: Int
    let focused: Bool
    let showRhythmActions: Bool

    let callback: (RhythmAction, Int) -> Void

    var body: some View {
        HStack {
            if showRhythmActions {
                RhythmActionButton(action: .focus, isOn: focused, callback: { callback($0, index) })
                    .layoutPriority(1)
            }

            ForEach(0 ..< rhythm.count, id: \.self) { i in
                RoundedRectangle(cornerRadius: 10)
                    .fill(rhythm.color)
                    .opacity(i == rhythm.selected ? selectedOpacity : unselectedOpacity)
            }
        }
    }

    var selectedOpacity: CGFloat {
        rhythm.volume == 1 ? 1 : 0.5
    }

    var unselectedOpacity: CGFloat {
        rhythm.volume == 1 ? 0.4 : 0.2
    }
}

struct RhythmView_Preview: PreviewProvider {
    @State private static var playing = true

    static var previews: some View {
        RhythmView(rhythm: .five, index: 1, focused: false, showRhythmActions: true, callback: { _, _ in })
            .frame(height: 100)
    }
}
