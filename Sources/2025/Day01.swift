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
        var position = 50
        var result = 0

        for turn in turns {
            position = (position + turn) % 100
            if position < 0 {
                position += 100
            }
            if position == 0 {
                result += 1
            }
        }
        return result

    }
    
    func part2() async -> Int {
        var position = 50
        var result = 0
        
        for turn in turns {
            let prevPosition = position
            position += turn
            
            while position > 100 {
                position -= 100
                result += 1
            }
            if prevPosition == 0 {
                position += 100
            }
            while position < 0 {
                position += 100
                result += 1
            }
            position %= 100
            if position == 0 {
                result += 1
            }
            // if temp < 0
        }
        
        return result
    }
}
