//: Playground - noun: a place where people can play

import Foundation

// Exercises 1 - 6

class Dummy {
    var name: String
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var dummyArray: [Dummy]? = [ Dummy(name: "A"), Dummy(name: "B"), Dummy(name: "C")]
var dummyArraySlice = dummyArray?[1...2]
type(of: dummyArraySlice!)

// dummyArraySlice![0] // fatal error: Index out of bounds

// NOTE: If order of these two lines is changed, different set of dummies is deinitialized - try this out
dummyArraySlice![1] = Dummy(name: "D")
dummyArray = nil

// Exercise 7

let sampleDict = [ 1: "one", 2: "two", 3: "three" ]
let rangeForSlicing = sampleDict.index(after: sampleDict.startIndex)..<sampleDict.endIndex
let sampleDictSlice = sampleDict[rangeForSlicing]
print(type(of: sampleDictSlice))

// Exercise 8

func allElementsEqual<C>(collection: C) -> Bool where C: Collection, C.Iterator.Element: Equatable {
    guard let firstElement = collection.first else {
        // Empty array is considered as having all elements equal
        return true
    }
    for element in collection.dropFirst() {
        if element != firstElement {
            return false
        }
    }
    return true
}

extension Collection where Iterator.Element: Equatable {
    func allElementsEqual() -> Bool {
        guard let firstElement = self.first else {
            // Empty array is considered as having all elements equal
            return true
        }
        for element in self.dropFirst() {
            if element != firstElement {
                return false
            }
        }
        return true
    }
}

extension Sequence where Iterator.Element: Equatable, SubSequence: Sequence, SubSequence.Iterator.Element == Iterator.Element {
    func allElementsEqual() -> Bool {
        var iterator = makeIterator()
        guard let firstElement = iterator.next() else {
            // Empty sequence is considered as having all elements equal
            return true
        }
        for element in self.dropFirst(1) {
            if element != firstElement {
                return false
            }
        }
        return true
    }
}

// Alternatively

extension Sequence where Iterator.Element: Equatable {
    func allElementsEqual2() -> Bool {
        var iterator = makeIterator()
        guard let firstElement = iterator.next() else {
            // Empty sequence is considered as having all elements equal
            return true
        }
        while let element = iterator.next() {
            if element != firstElement {
                return false
            }
        }
        return true
    }
}

allElementsEqual(collection: [1, 1, 1])
allElementsEqual(collection: [1, 1, 2])

// To be added later - in exercises
// a)
 allElementsEqual(collection: ["Ho", "Ho", "Ho"])
 allElementsEqual(collection: [-1.0, -1.00001, -0.99999])
// b)
 allElementsEqual(collection: [2, 1, 1].dropFirst())
// c)
 [1, 1, 1].allElementsEqual()
// d)
var counter = 0
let limit = 10
let constant = 1
let constantFiniteIterator = AnyIterator<Int> { () -> Int? in
    defer { counter += 1 }
    return counter < limit ? counter : nil
}
// NOTE: AnyIterator conforms to Sequence
 constantFiniteIterator.allElementsEqual2()

// Exercise 9

print(type(of: Array<String>.SubSequence.self))
print(type(of: Set<Int>.SubSequence.self))
print(type(of: Dictionary<Double, Bool>.SubSequence.self))

print("Executed")
