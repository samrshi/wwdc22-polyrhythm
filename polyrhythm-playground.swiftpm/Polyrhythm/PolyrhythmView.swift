//
//  PolyrhythmView.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/19/22.
//

import Combine
import SwiftUI

struct PolyrhythmView: View {
    @ObservedObject var manager: PolyrhythmManager
    let showRhythmActions: Bool
    
    var body: some View {
        VStack {
            ForEach(manager.rhythms.enumeratedArray(), id: \.element.id) { index, rhythm in
                RhythmView(rhythm: rhythm,
                           index: index,
                           focused: manager.rhythmIsFocused(index: index),
                           showRhythmActions: showRhythmActions,
                           callback: manager.handleRhythmAction)
            }
        }
    }
}
