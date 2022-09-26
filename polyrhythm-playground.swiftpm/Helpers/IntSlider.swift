//
//  IntSlider.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/19/22.
//

import SwiftUI

struct IntSlider: View {
    @Binding var value: Int
    let range: ClosedRange<Double>

    var intProxy: Binding<Double> {
        Binding<Double>(get: {
            // returns the score as a Double
            Double(value)
        }, set: {
            value = Int($0)
        })
    }

    var body: some View {
        VStack {
            Slider(value: intProxy, in: range, step: 1.0)
        }
    }
}
