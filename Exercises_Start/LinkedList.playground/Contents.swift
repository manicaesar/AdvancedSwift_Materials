//: Playground - noun: a place where people can play

class ListNode<T: Comparable> {
    var value: T
    var next: ListNode?
    init(value: T, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

extension ListNode: Comparable {
    static func ==(lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.value == rhs.value
    }
    static func <(lhs: ListNode, rhs: ListNode) -> Bool {
        return lhs.value < rhs.value
    }
}

class LinkedList<T: Comparable> {
    typealias Node = ListNode<T>
    private(set) var head: Node?
    private(set) var tail: Node?
    private(set) var count: Int = 0
    func prepend(value: T) -> LinkedList {
        let newHead = ListNode(value: value)
        newHead.next = head
        head = newHead
        if tail == nil {
            tail = newHead
        }
        count += 1
        return self
    }
}

extension LinkedList: Sequence {
    func makeIterator() -> AnyIterator<Node> {
        var node = head
        return AnyIterator({ () -> Node? in
            let toReturn = node
            node = node?.next
            return toReturn
        })
    }
}

/// NOTE: Subscripting does NOT execute in required O(1) time.
extension LinkedList: MutableCollection {
    typealias Index = Int
    
    var startIndex: Int {
        return 0
    }
    var endIndex: Int {
        return self.count
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    // NOTE1: Getter returns copy of the node; setter updates only value, not next pointer. In other words, this subscript has value semantics
    // NOTE2: This index does NOT execute in required O(1) time.
    subscript(i: Index) -> Node {
        get {
            guard i >= self.startIndex && i < self.endIndex else {
                fatalError()
            }
            var counter = self.startIndex
            var node = head
            while counter != i {
                formIndex(after: &counter)
                node = node?.next
            }
            return Node(value: node!.value, next: node!.next)
        }
        set {
            guard i >= self.startIndex && i < self.endIndex else {
                fatalError()
            }
            var counter = self.startIndex
            var node = head
            while counter != i {
                formIndex(after: &counter)
                node = node?.next
            }
            node!.value = newValue.value
        }
    }
}

extension LinkedList {
    func prettyPrint() -> String {
        return self.reduce("", { (desc, node) -> String in
            var newDesc = desc
            if !newDesc.isEmpty {
                newDesc.append("->")
            }
            newDesc.append("\(node.value)")
            return newDesc
        })
    }
}

var linkedList = LinkedList<Int>()
for i in 1...20 {
    linkedList.prepend(value: i)
}
linkedList.prettyPrint()
var copy = linkedList
copy[0] = ListNode(value: 100)
linkedList.prettyPrint()    // This list has reference semantics

print("Compiled")
