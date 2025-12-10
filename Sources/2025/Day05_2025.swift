import Foundation

struct Day05_2025: AdventOfCodeDay {
    let title = "Cafeteria"
    let freshIDs: [ClosedRange<Int>]
    let ids: [Int]

    init(input: String) {
        let inputs = input.lines.split(separator: "")
        freshIDs = inputs[0].map {
            let components = $0.components(separatedBy: "-")
            return Int(components[0])!...Int(components[1])!
        }
        
        ids = inputs[1].map {
            Int($0)!
        }
    }

    func part1() async -> Int {
        var result = 0
        for id in ids {
            for range in freshIDs {
                if range.contains(id) {
                    result += 1
                    break
                }
            }
        }
        return result
    }

    func part2() async -> Int {
        var ranges = freshIDs.sorted { $0.lowerBound < $1.lowerBound }
        var result = Set<ClosedRange<Int>>()

        // merge ranges
        while !ranges.isEmpty {
            let first = ranges.removeFirst()
            guard let second = ranges.first else {
                result.insert(first)
                break
            }
            if first.overlaps(second) {
                ranges[0] = first.lowerBound ... max(first.upperBound, second.upperBound)
            } else {
                result.insert(first)
            }
        }

        return result
            .map { $0.upperBound - $0.lowerBound + 1}
            .reduce(0, +)

    }
}
