//
//  Text+styles.swift
//  
//
//  Created by Samuel Shi on 4/24/22.
//

import SwiftUI

extension Text {
    func title() -> Text {
        self
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}
