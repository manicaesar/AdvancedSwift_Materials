//: Playground - noun: a place where people can play

struct Person {
    var name: String
    var age: Int
    var creditCard: CreditCard?
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct CreditCard {
    var number: String
    var expiryDate: MyDate
    init(number: String, expiryDate: MyDate) {
        self.number = number
        self.expiryDate = expiryDate
    }
}

struct MyDate {
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
var person = Person(name: "Mariusz Lisiecki", age: 30)
person.creditCard = creditCard

func findPropertyWithName(_ propertyName: String, in object: Any) -> Any? {
    // TODO: Implement me
    return nil
}

findPropertyWithName("year", in: person)    // Should return 2020
findPropertyWithName("name", in: person)    // Should return "Mariusz Lisiecki"
findPropertyWithName("number", in: person)  // Should return "1234 5678 9012 3456"

print("Compiled")
