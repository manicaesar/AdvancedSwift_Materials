//: Playground - noun: a place where people can play

import Foundation

// ----------- Optionals -----------------

let arrayWithNils = [ 0, nil, nil ]
print(type(of: arrayWithNils.first))

let dictWithNils: [String : Int?] = [ "one" : 1, "two" : 2, "fee" : nil ]
print(type(of: dictWithNils["one"]))
// prints "Optional(Optional(1))"
print(type(of: dictWithNils["fee"]))
// prints "Optional(nil)"

//let dictWithNilKey: [Int? : String] = [ nil : "nil", 1 : "one", 2 : "two"] // Does not compile, optionals does not conform to Hashable

let nonOpt = 1
let opt: Int? = 1

nonOpt == opt   // true
// What compiler does under the hood
Optional(nonOpt) == opt // Same as above

// ------------ Optional mapping -----------------

extension Collection {
    typealias Element = Self.Iterator.Element
    func reduce1(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        // Without optional mapping
        //        guard let fst = first else { return nil }
        //        let slice = dropFirst()
        //        return slice.reduce(fst, nextPartialResult)

        // With optional mapping
        return first.map { dropFirst().reduce($0, nextPartialResult) }
    }
}

["a", "b", "c"].reduce1(+)  // Optional("abc")
([] as [String]).reduce1(+)    // nil

// ----------- Comparing optional arrays -----------

let arr1 = [ 1, 2, 3 ]
let arr2 = [ 1, 2, 3 ]
let arr3 = [ 1, 2, nil ]
let arr4 = [ 1, 2, nil ]

arr1 == arr2
// arr3 == arr4    // Does not compile
// arr1 == arr3    // Does not compile as well

func optionalArraysEqual<W>(_ a1: Array<Optional<W>>, _ a2: Array<Optional<W>>) -> Bool where W: Equatable {
    guard a1.count == a2.count else { return false }
    
    for (index, element1) in a1.enumerated() {
        let element2 = a2[index]
        if element1 != element2 {
            return false
        }
    }
    
    return true
}

optionalArraysEqual([1, 2, nil], [1, 2, nil])
optionalArraysEqual([nil] as [String?], [nil, nil] as [String?])
