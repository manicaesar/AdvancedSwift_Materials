//: Playground - noun: a place where people can play

import Foundation

let dict = [ "Samanta Malinowska"   : [ 1, 3, 2, 4, 4, 3, 3, 2 ],
             "Brian Nowak"          : [ 5, 5, 4, 3, 2, 1, 5, 3 ],
             "Jessica Kowalska"     : [ 5, 3, 3, 4, 5, 6, 4, 4 ],
             "Justin Lewandowski"   : [ 1, 2, 3, 3, 5, 1, 2, 4 ] ]

// For each exercise, you should provide solution in one line of code, without defining additional methods

// Create an array of tuples where first element of tuple is the student name and second is his max remark
// *) Instead of array of tuples, create dictionary where keys are student names and values are their max remarks.

// Swift 4
let maxRemarks = Dictionary(uniqueKeysWithValues: dict.map { return ($0.0, $0.1.max()!) })
maxRemarks

// Calculate sum of all remarks

let sum = dict.values.flatMap { $0 }.reduce(0) { $0 + $1 }
sum

// Calculate mean of all remarks

let mean = Float(dict.values.flatMap { $0 }.reduce(0) { $0 + $1 }) / Float(dict.values.flatMap { $0 }.count)
mean

// Return list - names of students that does not have any 1 with the exception for first remark.
// In other words, having 1 as a first remark is acceptable if the student does not have any more 1's.
// *) Sort the list by student's surnames. You can assume that every student name has form: "<firstName><space><surname>"

let filtered = dict.filter { !$0.1.dropFirst().contains(1) }.map { $0.0 }.sorted { $0.components(separatedBy: " ")[1] < $1.components(separatedBy: " ")[1] }
filtered
