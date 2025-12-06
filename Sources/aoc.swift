// The Swift Programming Language
// https://docs.swift.org/swift-book
import ArgumentParser
import Foundation

@main
struct AOC: AsyncParsableCommand {
    @Argument(help: "The advent day", transform: { (raw: String) throws -> Day in
        if raw.lowercased() == "all" { return .allSequential }
        if raw.lowercased() == "all-parallel" { return .allParallel }
        guard let n = Int(raw), (1...12).contains(n) else {
            throw ValidationError("Invalid day: \(raw). Use 1...12, 'all', or 'all-parallel'.")
        }
        return .day(n)
    })
    var day: Day
    
    
    static var today: Day {
        let components = Calendar.current.dateComponents([.day, .month], from: Date())
        let day = components.day!
        if components.month == 12 && 1...12 ~= day {
            return .day(day)
        }
        return .allSequential
    }

    mutating func run() async throws {
        switch day {
        case .allSequential:
            for day in days {
                await day.init(input: day.input).run()
            }
        case .allParallel:
            await withTaskGroup(of: Void.self) { group in
                for day in days {
                    group.addTask {
                        await day.init(input: day.input).run()
                    }
                }
                for await _ in group {}
            }
        case .day(let day):
            let day = days[day - 1]
            await day.init(input: day.input).run()
        }

    }
    
    enum Day: CustomStringConvertible, Codable {
        case allSequential
        case allParallel
        case day(Int)

        var description: String {
            switch self {
            case .allSequential: return "all"
            case .allParallel: return "all-parallel"
            case .day(let n): return "day\(n)"
            }
        }
    }

    private let days: [any AdventOfCodeDay.Type] = [
        Day01.self, Day02.self, Day03.self
    ]
    
    private enum CodingKeys: String, CodingKey {
        case day
    }

}
