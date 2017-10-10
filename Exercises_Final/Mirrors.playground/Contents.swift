//: Playground - noun: a place where people can play

import CoreGraphics
import Foundation
import ObjectiveC.runtime

// Exercise 1

class Person {
    var name: String
    var age: Int
    var creditCard: CreditCard?
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class CreditCard {
    var number: String
    var expiryDate: MyDate
    init(number: String, expiryDate: MyDate) {
        self.number = number
        self.expiryDate = expiryDate
    }
}

class MyDate {
    var day: Int
    var month: Int
    var year: Int
    init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
}

let myDate = MyDate(day: 20, month: 2, year: 2020)
let creditCard = CreditCard(number: "1234 5678 9012 3456", expiryDate: myDate)
let person = Person(name: "Mariusz Lisiecki", age: 30)
person.creditCard = creditCard

func findPropertyWithName(_ propertyName: String, in object: Any) -> Any? {

    let mirror = Mirror(reflecting: object)
    guard mirror.children.count > 0 else {
        return nil
    }

    if let descendant = mirror.descendant(propertyName) {
        return descendant
    } else {
        for child in mirror.children {
            print("considering child: \(child)")
            if let descendant = findPropertyWithName(propertyName, in: child.value) {
                return descendant
            }
        }
        return nil
    }
}

findPropertyWithName("year", in: person)    // Should return 2020
findPropertyWithName("name", in: person)    // Should return "Mariusz Lisiecki"
findPropertyWithName("number", in: person)  // Should return "1234 5678 9012 3456"

// Exercises 2 and 3

@objc class Dummy: NSObject {
    @objc dynamic func methodA() {
        print("methodA")
    }
    
    @objc dynamic func methodB() {
        print("methodB")
    }
}

// Swizzling in Swift

var dummy: Dummy! = Dummy()
print("Before swizzling")
dummy.methodA()
dummy.methodB()
let selectorA = #selector(Dummy.methodA)
let selectorB = #selector(Dummy.methodB)
let methodA = class_getInstanceMethod(Dummy.self, selectorA)
let methodB = class_getInstanceMethod(Dummy.self, selectorB)
method_exchangeImplementations(methodA!, methodB!)
print("After swizzling")
dummy = Dummy()
dummy.methodA()
dummy.methodB()

// Adding methods in Swift

// a) From other class

class SomeOtherClass: NSObject {
    @objc func methodC() {
        print("methodC from \(self)")
    }
}

let socSelector = #selector(SomeOtherClass.methodC)
let socMethod = class_getInstanceMethod(SomeOtherClass.self, socSelector)!
let socImp = method_getImplementation(socMethod)

class_addMethod(Dummy.self, socSelector, socImp, nil)

let selFromString = NSSelectorFromString("methodC")
dummy.perform(selFromString)

// b) Custom block - simple

let blockImp: @convention(block) () -> Void = {
    print("Hello from blockImp")
}

let selectorToBeAdded = NSSelectorFromString("someMethod")
let imp = imp_implementationWithBlock(blockImp)

class_addMethod(Dummy.self, selectorToBeAdded, imp, "v@:")
dummy.perform(selectorToBeAdded)
