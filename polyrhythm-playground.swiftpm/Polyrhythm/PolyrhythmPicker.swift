//
//  PolyrhythmPicker.swift
//
//
//  Created by Samuel Shi on 4/25/22.
//

import SwiftUI

struct PolyrhythmPicker: View {
    @Binding var rhythmCount: Int
    let range: ClosedRange<Int>

    var body: some View {
        VStack {
            Text("\(rhythmCount)")
                .font(.system(size: 150))
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .overlay(alignment: .bottom) {
                    HStack {
                        Button {
                            if range.contains(rhythmCount - 1) {
                                rhythmCount -= 1
                            }
                        } label: {
                            Image(systemName: "minus")
                                .padding(.vertical)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(6)
                        }
                        .disabled(!range.contains(rhythmCount - 1))

                        Spacer()

                        Button {
                            if range.contains(rhythmCount + 1) {
                                rhythmCount += 1
                            }
                        } label: {
                            Image(systemName: "plus")
                                .padding(.vertical)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(6)
                        }
                        .disabled(!range.contains(rhythmCount + 1))
                    }
                }
        }
    }
}
