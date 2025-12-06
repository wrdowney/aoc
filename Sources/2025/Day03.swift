//
//  File.swift
//  aoc
//
//  Created by Will D on 12/6/25.
//

import Foundation

struct Day03: AdventOfCodeDay {
    let title = "Lobby"
    let banks: [[Int]]

    init(input: String) {
        banks = input
            .lines
            .map {
                $0.map {
                    Int(String($0))!
                }
            }
    }

    func part1() async -> Int {
        return banks.reduce(0) {
            return $0 + maxJoltage($1, numBatteries: 2)
        }
    }

    func part2() async -> Int {
        return banks.reduce(0) {
            return $0 + maxJoltage($1, numBatteries: 12)
        }
    }

    func maxJoltage(_ bank: [Int], numBatteries: Int) -> Int {
        var joltage = 0
        var start = bank.startIndex
        for offset in (0..<numBatteries).reversed() {
            let end = bank.endIndex - offset
            let (maxPos, max) = bank[start..<end].maxAndPosition()
            start += maxPos + 1
            joltage *= 10
            joltage += max
        }
        
        return joltage
    }
}

extension Array<Int>.SubSequence where Element == Int {
    func maxAndPosition() -> (Int, Int) {
        var max = (0, 0)
        for (i, element) in self.enumerated() {
            if element > max.1 {
               max = (i, element)
            }
        }
        return max
    }
}
