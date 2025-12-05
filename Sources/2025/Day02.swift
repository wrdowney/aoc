//
//  File.swift
//  aoc
//
//  Created by Will D on 12/5/25.
//

import Foundation

struct Day02: AdventOfCodeDay {
    let title = "Gift Shop"
    let ranges: [ClosedRange<Int>]
    
    init(input: String) {
        ranges = input
            .components(separatedBy: ",")
            .map {
                $0.components(separatedBy: "-")
            }
            .map {
                Int($0[0])! ... Int($0[1])!

            }
    }
    
    func part1() async -> Int {
        var result = 0
        for range in ranges {
            for i in range {
                result += isRepeatedTwice(i) ? i : 0
            }
        }
        return result
    }
    
    func part2() async -> Int {
        var result = 0
        for range in ranges {
            for i in range {
                result += isRepeated(i) ? i : 0
            }
        }
        return result
    }
    
    private func isRepeatedTwice(_ num: Int) -> Bool {
        let id = String(num)

        let mid = id.index(id.startIndex, offsetBy: id.count / 2)
        if id[..<mid] == id[mid...], id.count % 2 == 0 {
            return true
        }
        return false
    }
    
    private func isRepeated(_ num: Int) -> Bool {
        guard num >= 10 else { return false }
        let id = String(num)
        
        for i in 1...id.count / 2 {
            let windowEndIndex = id.index(id.startIndex, offsetBy: i)
            let window = String(id[..<windowEndIndex])
            if id == String(repeating: window, count: id.count / i) {
                return true
            }
        }
        
        return false
    }
}


