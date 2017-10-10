//: Playground - noun: a place where people can play

import Foundation

protocol StackProtocol {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
}

struct Stack<T>: StackProtocol {
    typealias Element = T
    
    private var storage: [T] = []
    
    mutating func push(_ element: T) {
        storage.append(element)
    }
    
    mutating func pop() -> T? {
        return storage.isEmpty ? nil : storage.removeLast()
    }
}

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

extension Stack: CustomDebugStringConvertible {
    var debugDescription: String {
        return storage.debugDescription
    }
}


var intStack: Stack<Int> = [ 1, 2, 3 ]
intStack.pop()
intStack.pop()

struct StackIterator<T>: IteratorProtocol {
    private(set) var stack: Stack<T>
    mutating func next() -> T? {
        return stack.pop()
    }
}

extension Stack: Sequence {
    func makeIterator() -> StackIterator<T> {
        return StackIterator(stack: self)
    }
}
[1].startIndex
intStack = [ 1, 4, 8 ]

for i in intStack {
    print(i)
}

// Make sure Stack is NOT unstable -> second traversal should yield same results
print("Second traversal")
for i in intStack {
    print(i)
}

extension Stack: Collection {
    typealias Index = Int
    
    var startIndex: Int {
        return storage.startIndex
    }
    
    var endIndex: Int {
        return storage.endIndex
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> T {
        return storage[storage.endIndex - 1 - position]
    }
}

intStack[0]
intStack[1]
intStack[3]

struct FibonacciSequence: Sequence {
    typealias Element = Int
    
    func makeIterator() -> AnyIterator<Int> {
        var state = (1, 1)
        return AnyIterator {
            let current = state.0
            state.0 = state.1
            state.1 = state.1 + current
            return current
        }
    }
}

let fibSequence = FibonacciSequence()
let first10Fibs = fibSequence.prefix(10)
print(Array(first10Fibs))
// let reversed = fibSequence.reversed()   // EXC_BAD_INSTRUCTION
