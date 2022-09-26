//
//  Sound.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/20/22.
//

import Foundation
import UIKit

public enum Sound: String, CaseIterable {
    case highClap
    case lowClap
    case click
    case tamborine
    case bottle
    
    var asset: (data: Data, type: String) {
        var name: String
        var type: String

        switch self {
        case .highClap:
            name = "high-clap"
            type = "m4a"
        case .lowClap:
            name = "low-clap"
            type = "m4a"
        case .click:
            name = "click"
            type = "mp3"
        case .tamborine:
            name = "tamborine"
            type = "mp3"
        case .bottle:
            name = "bottle"
            type = "mp3"
        }

        let asset = NSDataAsset(name: name)!
        return (data: asset.data, type: type)
    }
}
