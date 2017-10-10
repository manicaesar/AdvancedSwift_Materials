//: Playground - noun: a place where people can play

// Exercise 1

protocol Bird {
    func moveWings()
}

extension Bird {
    func moveWings() {
        print("Move your wings")
    }
    func fly() {
        for _ in 1...10 {
            moveWings()
        }
        print("I fly!")
    }
}

struct Penguin: Bird {
    func moveWings() {
        print("Clap your wings")
    }
    func fly() {
        print("I wish I can fly")
    }
}

let penguin = Penguin()
penguin.fly()

let penguinAsBird: Bird = Penguin()
penguinAsBird.fly()

// Exercise 2

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
    var pushImpl: (T) -> Void
    var popImpl: () -> T?
    
    init<S>(_ stack: S) where S: StackProtocol, S.Element == T {
        var stackCopy = stack
        pushImpl = { stackCopy.push($0) }
        popImpl = { return stackCopy.pop() }
    }
    
    typealias Element = T
    
    func push(_ element: T) {
        pushImpl(element)
    }
    
    func pop() -> T? {
        return popImpl()
    }
}

let anyStacks = [ AnyStack<Int>(structStack), AnyStack<Int>(classStack) ]
for stack in anyStacks {
    print("AnyStack.pop: \(stack.pop()!)")
}

// Exercise 3

let someInt: Int = 0
MemoryLayout.size(ofValue: someInt)
let csci: CustomStringConvertible = someInt
MemoryLayout.size(ofValue: csci)    // Existential container

let someString: String = "Hello, World!"
MemoryLayout.size(ofValue: someString)  // Note: size is fixed, because String internally uses buffer for storing characters
let cscs: CustomStringConvertible = someString
MemoryLayout.size(ofValue: cscs)    // Existential container again
