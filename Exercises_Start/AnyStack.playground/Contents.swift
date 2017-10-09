//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: Playground - noun: a place where people can play

import Foundation

protocol StackProtocol {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
}

struct StructStack<T>: StackProtocol {

    typealias Element = T

    private var storage: [T] = []

    mutating func push(_ element: T) {
        storage.append(element)
    }

    mutating func pop() -> T? {
        return storage.isEmpty ? nil : storage.removeLast()
    }
}

class ClassStack<T>: StackProtocol {
    typealias Element = T

    private var storage: [T] = []

    func push(_ element: T) {
        storage.append(element)
    }

    func pop() -> T? {
        return storage.isEmpty ? nil : storage.removeLast()
    }
}

// ------------------ Type Erasers ----------------------

var structStack = StructStack<Int>()
structStack.push(1)
var classStack = ClassStack<Int>()
classStack.push(2)

let array = [ structStack, classStack ] as [Any]

class AnyStack<T>: StackProtocol {
    // TODO
}

let anyStacks = [ AnyStack<Int>(structStack), AnyStack<Int>(classStack) ]
for stack in anyStacks {
    print("AnyStack.pop: \(String(describing: stack.pop()))")
}

print("Compiled")
