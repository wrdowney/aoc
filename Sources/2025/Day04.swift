import Foundation

struct Day04: AdventOfCodeDay {
    let title = "Printing Department"
    let grid: [[Character]]

    init(input: String) {
        grid = input.lines.map { Array($0) }
    }

    func part1() async -> Int {
        var tempGrid = grid
        return removeRollsOfPaper(grid: &tempGrid)
    }

    func part2() async -> Int {
        var tempGrid = grid
        var result = 0
        while true {
            let rollsRemoved = removeRollsOfPaper(grid: &tempGrid)
            guard rollsRemoved != 0 else { break }
            result += rollsRemoved
        }
        return result
    }
    
    func removeRollsOfPaper(grid: inout [[Character]]) -> Int {
        var result = 0
        var newGrid = grid
        let width = grid[0].count
        let height = grid.count

        for x in 0..<width {
            for y in 0..<height {
                guard grid[x][y] == "@" else { continue }

                var deltas = [-1, 0, 1].map { dx in
                    [-1, 0, 1].map { dy in
                        (dx, dy)
                    }
                }.flatMap { $0 }

                deltas.remove(at: deltas.firstIndex(where: { $0 == (0, 0) })!)

                var rolls = 0
                for deltas in deltas {

                    guard let nx = (x + deltas.0).bounded(by: 0..<width),
                        let ny = (y + deltas.1).bounded(by: 0..<height)
                    else { continue }
                    if grid[nx][ny] == "@" {
                        rolls += 1
                    }
                }
                
                if rolls < 4 {
                    result += 1
                    newGrid[x][y] = "."
                }
            }
        }
        grid = newGrid

        return result
    }
}


