//: Playground - noun: a place where people can play

import Foundation

// ---------------------- Ranges -------------------------

let range = "a"..<"z"
let closedRange = "a"..."z"
let range1 = 0.0..<1.0
let closedRange2 = 0.0...1.0
let countableRange = -10..<10
let countableClosedRange = -10...10

// Range is not a Sequence
//for r in range {}         // Does not compile

// Closed range is not a Sequence
//for cr in closedRange {}  // Does not compile

// However, countable ranges are Sequences (Collections, to be precise)
for _ in countableRange {}
for _ in countableClosedRange {}

// However, you can call count on Range... but only on those that have Strideable Bound with SignedInteger stride.
let intRange = Range<Int>(countableRange)
intRange.count
let stringRange = Range<String>(range)
// stringRange.count   // Does not compile, String is not Strideable
let doubleRange = Range<Double>(range1)
// doubleRange.count   // Does not compile, Double does not have SignedInteger Stride.

let ctrSI = countableRange.startIndex
// let ctr = countableRange[ctrSI] // Does not compile - ambiguous use of subscript - see documentation of CountableRange

// Workaround
func brackets<T>(_ x: CountableRange<T>, _ i: T) -> T {
    return x[i] // Just forward to subscript
}

print(brackets(countableRange, countableRange.startIndex))

let cctrSI = countableClosedRange.startIndex
let cctr1 = countableClosedRange[cctrSI]
// let cctr2 = countableClosedRange[0] // Does not compile - CountableClosedRange has its own custom Index, which is not Int

var partialRangeUpTo: PartialRangeUpTo<Float> = ..<5.0
var partialRangeThrough: PartialRangeThrough<Float> = ...5.0
var partialRangeFrom: PartialRangeFrom<Float> = 5.0...

// Does not compile, Float does not conform to SignedInteger
// var countablePartialRangeFrom: CountablePartialRangeFrom<Float> = 5.0...

// This compiles
var countablePartialRangeFrom: CountablePartialRangeFrom<Int> = 5...
