//
//  File.swift
//  aoc
//
//  Created by Will D on 12/6/25.
//

import Foundation

struct Day03: AdventOfCodeDay {
    let title = "Lobby"
    let banks: [Bank]
    
    init(input: String) {
        banks = input.lines.map { line in
            let batteries = line.map { Int(String($0))! }
            var bank = Bank(batteries: batteries)
            bank.findMaxJoltage()
            return bank
        }
    }
    
    func part1() async -> Int {
        return banks.reduce(0) { (sum, bank) in
            let (i, j) = bank.maxJoltage
            let combined = Int("\(i)\(j)")!
            return sum + combined
        }
    }
    
    func part2() async -> Int {
        return banks.count
    }
    
    struct Bank: Sendable {
        let batteries: [Int]
        var maxJoltage: (Int, Int) = (0, 0)
        
        mutating func findMaxJoltage() {
            var max = 0
            
            for i in 0..<batteries.count {
                for j in i+1..<batteries.count {
                    let battery1 = batteries[i]
                    let battery2 = batteries[j]
                    let combined = Int("\(battery1)\(battery2)")!
                    if combined > max {
                        max = combined
                        maxJoltage = (battery1, battery2)
                    }
                }
            }
        }
    }
}
