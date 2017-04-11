//: Playground - noun: a place where people can play

import UIKit

//: 16.2 - Find frequency of occurences of a word in a book. What if we were running multiple times?

// brute

typealias WordOccurences = [String : Int]
func findWords(book: [String]) -> WordOccurences {
    var occurences = WordOccurences()
    for word in book {
        if let numberOfOccurence = occurences[word] {
            occurences[word] = numberOfOccurence + 1
        } else {
            occurences[word] = 1
        }
    }
    return occurences
}

let book = ["Comma", "is", "a", "small", "CSV", "(", "ie", "comma", "separated", "values", "generation", "extension", "for", "Ruby", "objects", "that", "lets", "you", "seamlessly", "define", "a", "CSV", "output", "format", "via", "a", "small", "DSL"]

let comma = book.dropFirst().reduce(book[0], { "\($0.0), \($0.1)" })
comma

let occurences = findWords(book: book)

for occurence in occurences {
    //print("\(occurence.key) shows up \(occurence.value) times.")
}

func test() throws -> [Int] {
    guard 5 == 5 else { throw NSError() }
    return [1]
}


let slice = book[0..<2]

print(slice.count)

//: 16.5 Trailing zeroes of N factorial

extension Int {
    var factorial: Int {
        var returnValue = 1
        for index in 1...self {
            returnValue *= index
        }
        return returnValue
    }
    
    func digit(_ digit: Int) -> Int {
        return self / digit % 10
    }
}

5.factorial

343.digit(1000)


extension Int {
    var trailingZeroes: Int {
        let characters = String(self).characters.map { $0 }.reversed()
        var zeroes = 0
        for character in characters {
            if character == "0" {
                zeroes += 1
            } else {
                return zeroes
            }
        }
        return zeroes
    }
}

13.factorial.trailingZeroes

//: I guess this can be done more efficiently

func factorsOf5(i: Int) -> Int {
    var count = 0
    var copy = i
    while (copy % 5 == 0) {
        count += 1
        copy /= 5
    }
    return count
}


factorsOf5(i: 6025)















