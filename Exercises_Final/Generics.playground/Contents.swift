//: Playground - noun: a place where people can play

import UIKit

// Exercises 1 and 2

extension Sequence where Iterator.Element: Equatable {
    func isSubset<S>(of other: S) -> Bool
    where S: Sequence, S.Iterator.Element == Self.Iterator.Element
    {
        for element in self {
            guard other.contains(element) else { return false }
        }
        return true
    }
}

extension Sequence where Iterator.Element: Hashable {
    func isSubset<S>(of other: S) -> Bool
    where S: Sequence, S.Iterator.Element == Self.Iterator.Element
    {
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element) else { return false }
        }
        return true
    }
}

let numberArray = [ 1, 2, 3 ]
let animationOptionsArray: [UIViewAnimationOptions]
    = [ .allowAnimatedContent, .allowUserInteraction, .autoreverse ]

[ 3, 4 ].isSubset(of: numberArray)  // false, uses 'Hashable' version
[ .autoreverse ].isSubset(of: animationOptionsArray)    // true, uses 'Equatable' version

// Exercise 3

extension MutableCollection where
    Self: RandomAccessCollection,
    Index == Int,
    IndexDistance == Int,
    Self.Iterator.Element: Comparable
{
    mutating func bubbleSort() {
        for i in self.startIndex..<self.endIndex - 1 {
            for j in 0..<self.endIndex - 1 - i {
                if self[j] > self[j + 1] {
                    let temp = self[j]
                    self[j] = self[j + 1]
                    self[j + 1] = temp
                }
            }
        }
    }
}

var array = [Int]()
for i in 1...20 {
    array.insert(i, at: 0)
}

array
array.bubbleSort()

// Exercises 4 and 5

//extension Array: Equatable where Element: Equatable {} // Does not compile

//let mySwap = swap // Does not compile
let myIntSwap: ((inout Int, inout Int) -> Void) = swap  // This compiles
