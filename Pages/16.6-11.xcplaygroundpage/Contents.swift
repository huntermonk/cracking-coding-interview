//: [Previous](@previous)

import Foundation

//: 16.6
//: Given two arrays, find the smallest non-negative difference between two pairs.
//: [1, 3, 15, 11, 2] & [23, 127, 235, 19, 8]. Answer is (11, 8)

func smallestDifference(lhs: [Int], rhs: [Int]) -> Int {
    let lhsSorted = lhs.sorted()
    let rhsSorted = rhs.sorted()
    
    // lhs: [1, 2, 3, 11, 15]
    // rhs: [8, 19, 23, 127, 235]
    
    var lhsIndex = 0
    var rhsIndex = 0
    
    var difference = Int.max
    
    while lhsIndex < lhsSorted.count && rhsIndex < rhsSorted.count {
        let interimDifference = abs(lhsSorted[lhsIndex] - rhsSorted[rhsIndex])
        if interimDifference < difference {
            difference = interimDifference
        }
        
        // Move smaller value
        if lhsSorted[lhsIndex] < rhsSorted[rhsIndex] {
            lhsIndex += 1
        } else {
            rhsIndex += 1
        }
    }
    
    return difference
}

let first = [1, 3, 15, 11, 2]
let second = [23, 127, 235, 19, 8]

smallestDifference(lhs: first, rhs: second)

//: 16.8 - Describe integer in English 1004 -> One thousand four

// Assuming limit is thousands

extension Int {
    func digit(_ digit: Int) -> Int {
        return self / digit % 10
    }
}

extension Int {
    var isInThousands: Bool {
        return self / 1000 >= 1
    }
    
    var isInHundreds: Bool {
        return self / 100 >= 1
    }
    
    var isInTens: Bool {
        return self / 10 >= 1
    }
    
    var toEnglish: String {
        guard self != 0 else { return "zero" }
        var asSentence = self > 0 ? "" : "negative "
        if isInThousands {
            let thousands = digit(1000)
            if thousands != 0 {
                asSentence += "\(asWord(digit: thousands)) thousand, "
            }
        }
        if isInHundreds {
            let hundreds = digit(100)
            if hundreds != 0 {
                asSentence += "\(asWord(digit: hundreds)) hundred, "
            }
        }
        if isInTens {
            let tens = digit(10)
            if tens != 0 {
                let modulo = self % 100
                if self >= 10 && self < 20 {
                    asSentence += "\(asWord(digit: self))"
                    return asSentence
                } else if modulo >= 10 && modulo < 20 {
                    asSentence += "\(asWord(digit: modulo))"
                    return asSentence
                } else {
                    asSentence += "\(asWord(digit: tens * 10)) "
                }
            }
        }
        
        asSentence += asWord(digit: digit(1))
        
        return asSentence
    }
    
    func asWord(digit: Int) -> String {
        switch digit {
        case 0: return ""
        case 1: return "one"
        case 2: return "two"
        case 3: return "three"
        case 4: return "four"
        case 5: return "five"
        case 6: return "six"
        case 7: return "seven"
        case 8: return "eight"
        case 9: return "nine"
        case 10: return "ten"
        case 11: return "eleven"
        case 12: return "twelve"
        case 13: return "thirteen"
        case 14: return "fourteen"
        case 15: return "fifteen"
        case 16: return "sixteen"
        case 17: return "seventeen"
        case 18: return "eighteen"
        case 19: return "nineteen"
        case 20: return "twenty"
        case 30: return "thirty"
        case 40: return "fourty"
        case 50: return "fifty"
        case 60: return "sixty"
        case 70: return "seventy"
        case 80: return "eighty"
        case 90: return "ninety"
        default: fatalError()
        }
    }
}

311.toEnglish

//: [Next](@next)


//: 16.9 - Implement multiply, subtract and divide for integers. Only use add operator. Answers can just be integers.

extension Int {
    func subtract(_ amount: Int) -> Int {
        return self + -amount
    }
    
    func multiply(_ amount: Int) -> Int {
        guard amount != 0 else { fatalError() }
        var value = 0
        for _ in 1...amount {
            value += self
        }
        if amount < 0 {
            return -value
        }
        return value
    }
    
    func divide(_ amount: Int) -> Int {
        var value = 0
        var interim = amount
        while interim <= self {
            value += 1
            interim += amount
        }
        return value
    }
}

(4).multiply(2)
115.divide(20)

//: 16.10 Given a list of peoples birth and death years, find year with most people alive. It's from 1900 to 2000 inclusive. If a person was alive at all during that year, they count. Someone living from 1908 - 1909 counts for both years.


typealias LifeRecord = (born: Int, died: Int)
let array = [LifeRecord]()

func mostPopulousYear(records: [LifeRecord]) -> Int? {
    let sorted = records.sorted(by: { $0.0.died < $0.1.died })
    var mostPopulous: (year: Int, people: Int)?
    
    for year in 1900...2000 {
        var people = 0
        for person in sorted {
            if year >= person.born && year <= person.died {
                people += 1
            }
            if let populous = mostPopulous {
                if people > populous.people {
                    mostPopulous = (year, people)
                }
            } else {
                mostPopulous = (year, people)
            }
            if person.died < year {
                break
            }
        }
    }
    return mostPopulous?.year
}

let people = [(1856, 2004), (1944, 1948), (1948, 1990)]

mostPopulousYear(records: people)

func optimizedMostPopulousYear(people: [LifeRecord], min: Int, max: Int) -> Int {
    let birthYears = people.map({ $0.born }).sorted()
    let deathYears = people.map({ $0.died }).sorted()
    
    var birthIndex = 0
    var deathIndex = 0
    var currentlyAlive = 0
    var mostPopulous: (year: Int, people: Int) = (0, 0)
    
    while birthIndex < birthYears.count {
        if birthYears[birthIndex] <= deathYears[deathIndex] {
            currentlyAlive += 1
            if currentlyAlive > mostPopulous.people {
                mostPopulous = (birthYears[birthIndex], currentlyAlive)
            }
            birthIndex += 1
        } else if birthYears[birthIndex] > deathYears[deathIndex] {
            currentlyAlive -= 1
            deathIndex += 1
        }
    }
    return mostPopulous.year
}

optimizedMostPopulousYear(people: people, min: 1900, max: 2000)


//: 16.11 Given two plank lengths and a number of planks you can use, find all possible lengths for a diving board. Diving board has planks end-to-end.

func allLengths(k: Int, shorter: Int, longer: Int) -> Set<Int> {
    var lengths = Set<Int>()
    getAllLengths(k: k, total: 0, shorter: shorter, longer: longer, length: &lengths)
    return lengths
}

func getAllLengths(k: Int, total: Int, shorter: Int, longer: Int, length: inout Set<Int>) {
    
}

func optimizedGetLengths(short: Int, long: Int, boards: Int) -> [Int] {
    var lengths = [Int]()
    for index in 0...boards {
        lengths.append(short * index + (boards - index) * long)
    }
    return lengths
}

let lengths = optimizedGetLengths(short: 3, long: 8, boards: 5)


