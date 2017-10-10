//: Playground - noun: a place where people can play

import Foundation

// --------------- Dictionaries --------------

// There is no map that creates new dictionary
//let dict = [1 : "one", 2 : "two", 3 : "three"]
//let mapResult = dict.map {
//    return "\($0.0):" + $0.1
//}
//mapResult

// Breaking dictionary

class Dummy {
    var name: String
    init(name: String) {
        self.name = name
    }
}

func ==(lhs: Dummy, rhs: Dummy) -> Bool {
    return lhs.name == rhs.name
}

extension Dummy: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}

var d1 = Dummy(name: "Ewa")
var d2 = Dummy(name: "Kasia")

let dummyDict = [ d1: 18, d2: 24]
let dummySet: Set<Dummy> = [ d1, d2 ]
dummyDict[d1]
dummySet.contains(d1)
d1.name = "Ela" // This breaks both Dictionary and Set
dummyDict[d1]
dummySet.contains(d1)
dummyDict
dummySet

print("Compiled")
