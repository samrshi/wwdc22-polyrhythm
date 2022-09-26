//
//  Collection+convenience.swift
//  polyrhythm
//
//  Created by Samuel Shi on 4/20/22.
//

import Foundation

extension Collection {
    func enumeratedArray() -> [(offset: Int, element: Self.Element)] {
        Array(enumerated())
    }

    func replaceEach<T>(with value: T) -> [T] {
        map { _ in value }
    }

    func replaceEach<Target>(at keypath: WritableKeyPath<Element, Target>, with value: Target) -> [Element] {
        map {
            var element = $0
            element[keyPath: keypath] = value
            return element
        }
    }
}

extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get {
            return index >= startIndex && index < endIndex ? self[index] : nil
        }
        mutating set {
            guard let value = newValue, index >= startIndex, index < endIndex else { return }
            self[index] = value
        }
    }
}
