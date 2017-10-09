//: Playground - noun: a place where people can play

extension Collection {
    mutating func bubbleSort() {
        for i in self.startIndex..<self.endIndex - 1 {
            for j in 0..<self.endIndex - 1 - i {
                if self[j] > self[j + 1] {
                    let temp = self[j]
                    self[j] = self[j + 1]
                    self[j + 1] = temp
                }
            }
        }
    }
}

print("Compiled")
