import Foundation

struct Day05_2025: AdventOfCodeDay {
    let title = "Cafeteria"
    var freshIDs: Set<ClosedRange<Int>>
    let ids: [Int]

    init(input: String) {
        let inputs = input.lines.split(separator: "")
        var ranges = inputs[0].map {
            let components = $0.components(separatedBy: "-")
            return Int(components[0])!...Int(components[1])!
        }.sorted { $0.lowerBound < $1.lowerBound }
        
        freshIDs = .init()

        // merge ranges
        while !ranges.isEmpty {
            let first = ranges.removeFirst()
            guard let second = ranges.first else {
                freshIDs.insert(first)
                break
            }
            if first.overlaps(second) {
                ranges[0] = first.lowerBound ... max(first.upperBound, second.upperBound)
            } else {
                freshIDs.insert(first)
            }
        }
        
        ids = inputs[1].map {
            Int($0)!
        }
    }

    func part1() async -> Int {
        return ids.filter{ id in
            for range in freshIDs {
                if range.contains(id) { return true }
            }
            return false
        }.count
    }

    func part2() async -> Int {
        return freshIDs
            .map { $0.upperBound - $0.lowerBound + 1}
            .reduce(0, +)

    }
}
