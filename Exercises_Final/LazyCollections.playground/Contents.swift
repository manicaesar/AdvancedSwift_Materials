//: Playground - noun: a place where people can play

import Foundation

class Dummy: CustomDebugStringConvertible {
    let value: Int
    let printOnDeinit: Bool
    init(value: Int, printOnDeinit: Bool) {
        self.value = value
        self.printOnDeinit = printOnDeinit
    }
    convenience init(value: Int) {
        self.init(value: value, printOnDeinit: false)
    }

    deinit {
        if printOnDeinit {
            print("Deiniting dummy with value: \(value)")
        }
    }

    var debugDescription: String {
        return "Dummy with value: \(value)"
    }
}

let numbers1 = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

var dummies1: [Dummy]? = numbers1.map { Dummy(value: $0, printOnDeinit: true) }

let mappedDummies = dummies1?.map { $0.value }
let lazyMappedDummies = dummies1?.lazy.map { $0.value }

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

let numbers2 = [ 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 ]

// Exercise 2 goes here

measure(label: "a") {
    let _ = numbers2.map { Dummy(value: $0) }
}

measure(label: "b") {
    let _ = numbers2.lazy.map { Dummy(value: $0) }
}

measure(label: "c") {
    let dummiesC = numbers2.map { Dummy(value: $0) }
    for dummy in dummiesC {
        print(dummy)
    }
}

measure(label: "d") {
    let dummiesD = numbers2.lazy.map { Dummy(value: $0) }
    for dummy in dummiesD {
        print(dummy)
    }
}
