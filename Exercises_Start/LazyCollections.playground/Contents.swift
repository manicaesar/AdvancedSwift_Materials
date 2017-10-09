//: Playground - noun: a place where people can play

import Foundation

class Dummy: CustomDebugStringConvertible {
    let value: Int
    init(value: Int) {
        self.value = value
    }

    deinit {
        print("Deiniting dummy with value: \(value)")
    }

    var debugDescription: String {
        return "Dummy with value: \(value)"
    }
}

let numbers1 = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

var dummies1: [Dummy]? = numbers1.map { Dummy(value: $0) }

// Exercise 1 goes here

dummies1 = nil

print("\n-----------Measuring------------\n")

func measure(label: String, block: () -> ()) {
    print("Entering measure block: \(label)")
    let startDate = Date()
    block()
    let endDate = Date()
    let diff = endDate.timeIntervalSince(startDate)
    print("Diff: \(diff)")
}

let numbers2 = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

// Exercise 2 goes here
