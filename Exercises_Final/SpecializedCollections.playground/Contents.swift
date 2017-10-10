//: Playground - noun: a place where people can play

import Foundation

extension RandomAccessCollection where Self.Iterator.Element: Comparable {
    
    func binarySearch(element: Self.Iterator.Element) -> Index? {
        
        guard !isEmpty else {
            return nil
        }
        
        var leftIndex = startIndex
        var rightIndex = index(before: endIndex)

        while leftIndex <= rightIndex {
            let dist = distance(from: leftIndex, to: rightIndex)
            let middleIndex = index(leftIndex, offsetBy: dist / 2)
        
            let candidate = self[middleIndex]
            
            if candidate == element {
                return middleIndex
            }
            
            if candidate < element {
                leftIndex = index(after: middleIndex)
            } else {
                // candidate > element
                rightIndex = index(before: middleIndex)
            }
        }
        
        return nil
    }
}

let sampleCollection = [ 1, 3, 4, 7, 8, 10, 11, 24 ]
sampleCollection.binarySearch(element: 3) // should return 1
sampleCollection.binarySearch(element: 11) // should return 6
sampleCollection.binarySearch(element: 16) // should return nil
[1].binarySearch(element: 1)
print("Compiled")

// Recursive approach - explanation why it will not work

/*
 
extension RandomAccessCollection where Self.Iterator.Element: Comparable {
    
    func binarySearch(element: Self.Iterator.Element) -> Index? {
        guard !isEmpty else {
            return nil
        }
        
        let dist = distance(from: startIndex, to: index(before: endIndex))
        let middleIndex = index(startIndex, offsetBy: dist / 2)
        
        let candidate = self[middleIndex]
        
        if candidate == element {
            return middleIndex
        }
        
        
        let result = self[middleIndex...endIndex]
        
        let subsequences = split(separator: candidate, maxSplits: 1, omittingEmptySubsequences: false)
        
        if candidate < element {
            // This will not compile, because SubSequence is not RandomAccessCollection, so it will not have binarySearch method available...
            // In theory, there are two options here:
            // 1) Add generic constraint to extension: Self.SubSequence: RandomAccessCollection (+ constraint on its elements), but in such case compiler will complain that Self.SubSequence.SubSequence is not RandomAccessCollection...
            // 2) Add generic constraint to extension: Self.SubSequence == Self, but in such case binarySearch method will not be available for Array...
            return subsequences[1].binarySearch(element: element)
        } else {
            // candidate > element
            return subsequences[0].binarySearch(element: element)
        }
    }
}

*/
