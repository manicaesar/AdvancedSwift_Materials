//: Playground - noun: a place where people can play

import Foundation

func allElementsEqual(array: Array<Int>) -> Bool {
    guard let firstElement = array.first else {
        // Empty array is considered as having all elements equal
        return true
    }
    for element in array.dropFirst() {
        if element != firstElement {
            return false
        }
    }
    return true
}

allElementsEqual(array: [1, 1, 1])
allElementsEqual(array: [1, 1, 2])

// To be added later - in exercises
// a)
// allElementsEqual(array: ["Ho", "Ho", "Ho"])
// allElementsEqual(array: [-1.0, -1.00001, -0.99999])
// b)
// allElementsEqual(array: [2, 1, 1].dropFirst())
// c)
// [1, 1, 1].allElementsEqual()
// d)
var counter = 0
let limit = 10
let constant = 1
let constantFiniteIterator = AnyIterator<Int> { () -> Int? in
    defer { counter += 1 }
    return counter < limit ? constant : nil
}
// NOTE: AnyIterator conforms to Sequence
// constantFiniteIterator.allElementsEqual()

print("Executed")
