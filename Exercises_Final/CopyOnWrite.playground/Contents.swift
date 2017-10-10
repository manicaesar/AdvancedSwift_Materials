//: Playground - noun: a place where people can play

import Foundation

// Slides - checking CopyOnWrite behaviour

var mutableArray = [ 1, 2, 3 ]
for _ in mutableArray {
    mutableArray.removeAll()
    print("For loop executed")
}

var nsmutableArray: NSMutableArray = [ 1, 2, 3 ]
//for _ in nsmutableArray {
//    nsmutableArray.removeAllObjects() // Will cause EXC_BAD_ACCESS
//    print("For loop executed")
//}

// In contrary to Swift Array, NSMutableArray works via reference
var anotherNSMutableArray = nsmutableArray
anotherNSMutableArray.add(4)
nsmutableArray
anotherNSMutableArray

var nsmutableArrayCopy = nsmutableArray.mutableCopy() as! NSMutableArray
nsmutableArrayCopy.add(5)
nsmutableArray
nsmutableArrayCopy

// Exercise 1

var arrayOfStrings = [ "one", "two", "three" ] {
    didSet {
        print("arrayOfStrings changed")
    }
}
arrayOfStrings[0].append("111")

var arrayOfNSMutableStrings = [ NSMutableString(string: "one"), NSMutableString(string: "two"), NSMutableString(string: "three") ] {
    didSet {
        print("arrayOfNSMutableStrings changed")
    }
}
arrayOfNSMutableStrings[0].append("111")

// Exercise 2

protocol StackProtocol {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element
}

class InternalStack<T> : StackProtocol {
    init() {
        print("InternalStack being initialized")
    }
    func copy() -> InternalStack<T> {
        let copy = InternalStack<T>()
        copy.storage = storage
        return copy
    }
    private var storage = [T]()
    func push(_ element: T) {
        storage.append(element)
    }
    func pop() -> T {
        return storage.removeLast()
    }
}

struct StackCOW<T> : StackProtocol {
    private var internalStack = InternalStack<T>()

    private mutating func uniqueInternalStack() -> InternalStack<T> {
        if !isKnownUniquelyReferenced(&internalStack) {
            internalStack = internalStack.copy()
        }
        return internalStack
    }

    mutating func push(_ element: T) {
        uniqueInternalStack().push(element)
    }
    mutating func pop() -> T {
        return uniqueInternalStack().pop()
    }
}

var stack = Optional(StackCOW<Int>())
stack?.push(1)
stack?.push(2)
var stackCopy = stack! // References should be shared - no actual copy should be performed yet
// stack = nil  // Uncomment to remove need for copy on write
stackCopy.push(3) // Copy on write should fire - actual copy should be performed here
stack?.pop() // Returns 2
stackCopy.pop() // Returns 3

