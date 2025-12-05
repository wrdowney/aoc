//
//  File.swift
//  aoc
//
//  Created by Will D on 12/5/25.
//

import Foundation

struct Day01: AdventOfCodeDay {
    let title = "Secret Entrance"
    let turns: [Int]
    
    init(input: String) {
        self.turns = input.lines.map { str in
            let sign = str.first == "L" ? -1 : 1
            let value = Int(str.dropFirst())!
            return sign * value
        }
    }
    
    func part1() async -> Int {
        print(turns)
        return turns.count
    }
    
    func part2() async -> Int {
        return turns.count
    }
}
