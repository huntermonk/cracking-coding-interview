//: [Previous](@previous)

import Foundation

//: 16.17 Find contiguous sequence with largest sum.

let array = [1, 2, 3, 4, 5]
array.reduce(0, +)

func getMaxSum(array: [Int]) -> Int {
    var maxSum = 0
    var sum = 0
    for item in array {
        sum += item
        if maxSum < sum {
            maxSum = sum
        } else if sum < 0 {
            sum = 0
        }
    }
    return maxSum
}

let test = [1, -3, 4, 5, -4]
getMaxSum(array: test)


//: [Next](@next)
