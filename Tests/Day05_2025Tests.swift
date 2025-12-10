import Testing

@testable import aoc

private let testInput = """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """
@Suite("Day 5 2025 Tests")
struct Day05_2025Tests {
    @Test("Day 5 2025 Part 1", .tags(.testInput))
    func testDay05_2025_part1() async {
        let day = Day05_2025(input: testInput)
        await #expect(day.part1() == 3)
    }

    @Test("Day 5 2025 Part 1 Solution")
    func testDay05_2025_part1_solution() async {
        let day = Day05_2025(input: Day05_2025.input)
        await #expect(day.part1() == 643)
    }

    @Test("Day 5 2025 Part 2", .tags(.testInput))
    func testDay05_2025_part2() async {
        let day = Day05_2025(input: testInput)
        await #expect(day.part2() == 14)
    }

    @Test("Day 5 2025 Part 2 Solution")
    func testDay05_2025_part2_solution() async {
        let day = Day05_2025(input: Day05_2025.input)
        await #expect(day.part2() == 342018167474526)
    }
}

