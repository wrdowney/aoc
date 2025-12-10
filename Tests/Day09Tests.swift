import Testing

@testable import aoc

private let testInput = """
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    """
@Suite("Day 9 Tests")
struct Day09Tests {
    @Test("Day 9 Part 1", .tags(.testInput))
    func testDay09_part1() async {
        let day = Day09(input: testInput)
        await #expect(day.part1() == 50)
    }

    @Test("Day 9 Part 1 Solution")
    func testDay09_part1_solution() async {
        let day = Day09(input: Day09.input)
        await #expect(day.part1() == 4748985168)
    }

    @Test("Day 9 Part 2", .tags(.testInput))
    func testDay09_part2() async {
        let day = Day09(input: testInput)
        await #expect(day.part2() == 24)
    }

    @Test("Day 9 Part 2 Solution")
    func testDay09_part2_solution() async {
        let day = Day09(input: Day09.input)
        await #expect(day.part2() == 1550760868)
    }
}
