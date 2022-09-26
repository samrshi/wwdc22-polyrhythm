//
//  SamsIntroductionView.swift
//
//
//  Created by Samuel Shi on 4/24/22.
//

import SwiftUI

struct SamsIntroductionView: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 24) {
                Text(introCopy)

                Text(rhythmCopy)
                
                Text(polyrhythmCopy)

                NavigationLink {
                    SubdivisionIntroductionView()
                } label: {
                    Text("Learn about polyrhythms!!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .font(.title2)

            Image("headshot")
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
                .padding([.leading], 75)
        }
        .padding()
        .navigationTitle("Hi there!!")
    }

    var introCopy: String {
        "My name is Sam and I have played the drums for nearly my entire life. My favorite part of drumming is being able to approach music mathematically since I’ve always loved both music and math."
    }

    var rhythmCopy: String {
        "Because drums are such rhythmic instruments, you really need focus on placing your notes in time exactly where they belong. "
    }
    
    var polyrhythmCopy: String {
        "Polyrhythms are one part of music where this is especially important. Unfortunately, however, I noticed that a lot of people struggle to get a hang of them. Let's do something about that!"
    }
}
