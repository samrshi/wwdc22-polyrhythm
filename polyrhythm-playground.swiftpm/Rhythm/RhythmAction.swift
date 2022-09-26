//
//  RhythmAction.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/20/22.
//

import SwiftUI

enum RhythmAction {
    case focus

    var symbolName: String {
        switch self {
        case .focus: return "headphones"
        }
    }
    
    var accessibilityLabel: String {
        switch self {
        case .focus: return "Focus"
        }
    }
    
    var accessibilityHint: String {
        switch self {
        case .focus: return "Focus this rhythm by increasing it's relative volume"
        }
    }
}

struct RhythmActionButton: View {
    let action: RhythmAction
    let isOn: Bool
    let callback: (RhythmAction) -> Void

    var body: some View {
        Button {
            callback(action)
        } label: {
            Rectangle()
                .fill(isOn ? Color.blue : Color(.secondarySystemBackground))
                .opacity(0.75)
                .overlay { icon }
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(10)
        }
        .accessibilityLabel(action.accessibilityLabel)
        .accessibilityHint(action.accessibilityHint)
    }

    var icon: some View {
        Image(systemName: action.symbolName)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(isOn ? .white : .primary)
    }
}
