import Foundation

struct Day09: AdventOfCodeDay {
    var title = "Movie Theater"
    var redTiles: [Tile] = []
    var greenTiles: Set<Tile> = []
    var filledSpansByRow: [Int: [ClosedRange<Int>]] = [:]

    init(input: String) {
        redTiles = input.lines.map {
            let coords = $0.components(separatedBy: ",")
            return Tile(x: Int(coords[0])!, y: Int(coords[1])!)
        }
        for i in 0..<redTiles.count {
            let tileA = redTiles[i]
            var tileB: Tile
            if i == redTiles.count - 1 {
                tileB = redTiles[0]
            } else {
                tileB = redTiles[i + 1]
            }
            let connectedByColumn = tileA.x == tileB.x
            let connectedByRow = tileA.y == tileB.y
            
            let higherCoord = connectedByColumn ? max(tileA.y, tileB.y) : max(tileA.x, tileB.x)
            let lowerCoord = connectedByColumn ? min(tileA.y, tileB.y) : min(tileA.x, tileB.x)
            
            if connectedByColumn {
                for j in lowerCoord...higherCoord {
                    greenTiles.insert(Tile(x: tileA.x, y: j))
                }
            }
            
            if connectedByRow {
                for j in lowerCoord...higherCoord {
                    greenTiles.insert(Tile(x: j, y: tileA.y))
                }
            }
        }
        
        func mergeSpans(_ spans: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
            guard !spans.isEmpty else { return [] }
            let sorted = spans.sorted { $0.lowerBound < $1.lowerBound }
            var result: [ClosedRange<Int>] = []
            var current = sorted[0]
            for s in sorted.dropFirst() {
                if s.lowerBound <= current.upperBound + 1 {
                    current = current.lowerBound...max(current.upperBound, s.upperBound)
                } else {
                    result.append(current)
                    current = s
                }
            }
            result.append(current)
            return result
        }

        var intersectionsByRow: [Int: [Int]] = [:]
        for i in 0..<redTiles.count {
            let a = redTiles[i]
            let b = redTiles[(i + 1) % redTiles.count]
            if a.x == b.x {
                let x = a.x
                let yLow = min(a.y, b.y)
                let yHigh = max(a.y, b.y)
                if yLow != yHigh {
                    for y in yLow..<yHigh {
                        intersectionsByRow[y, default: []].append(x)
                    }
                }
            }
        }

        // Build interior spans from paired intersections
        var spansByRow: [Int: [ClosedRange<Int>]] = [:]
        for (y, xs) in intersectionsByRow {
            let sortedXs = xs.sorted()
            var spans: [ClosedRange<Int>] = []
            var idx = 0
            while idx + 1 < sortedXs.count {
                let x1 = sortedXs[idx]
                let x2 = sortedXs[idx + 1]
                spans.append(x1...x2)
                idx += 2
            }
            spansByRow[y] = spans
        }

        for i in 0..<redTiles.count {
            let a = redTiles[i]
            let b = redTiles[(i + 1) % redTiles.count]
            if a.y == b.y {
                let y = a.y
                let xLow = min(a.x, b.x)
                let xHigh = max(a.x, b.x)
                spansByRow[y, default: []].append(xLow...xHigh)
            }
        }

        var finalSpans: [Int: [ClosedRange<Int>]] = [:]
        for (y, spans) in spansByRow {
            finalSpans[y] = mergeSpans(spans)
        }
        self.filledSpansByRow = finalSpans
    }

    func part1() async -> Int {
        var maxArea = 0
        for i in 0..<redTiles.count {
            for j in i + 1..<redTiles.count {
                let deltaX = abs(redTiles[i].x - redTiles[j].x)
                let deltaY = abs(redTiles[i].y - redTiles[j].y)
                let area = (deltaX + 1) * (deltaY + 1)
                maxArea = max(maxArea, area)
            }
        }
        return maxArea
    }

    func part2() async -> Int {
        var maxArea = 0

        func rowCovers(_ y: Int, _ minX: Int, _ maxX: Int) -> Bool {
            guard let spans = filledSpansByRow[y], !spans.isEmpty else { return false }
            var lo = 0
            var hi = spans.count - 1
            while lo <= hi {
                let mid = (lo + hi) / 2
                let s = spans[mid]
                if s.lowerBound > minX {
                    hi = mid - 1
                } else if s.upperBound < minX {
                    lo = mid + 1
                } else {
                    return s.upperBound >= maxX
                }
            }
            if hi >= 0 {
                let s = spans[hi]
                if s.lowerBound <= minX && s.upperBound >= maxX { return true }
            }
            return false
        }

        let n = redTiles.count
        for i in 0..<n {
            let xi = redTiles[i].x
            let yi = redTiles[i].y
            for j in (i + 1)..<n {
                let xj = redTiles[j].x
                let yj = redTiles[j].y
                if xi == xj || yi == yj { continue }

                let minX = min(xi, xj)
                let maxX = max(xi, xj)
                let minY = min(yi, yj)
                let maxY = max(yi, yj)

                let area = (maxX - minX + 1) * (maxY - minY + 1)
                if area <= maxArea { continue }

                if !rowCovers(minY, minX, maxX) { continue }
                if !rowCovers(maxY, minX, maxX) { continue }

                var ok = true
                var y = minY + 1
                while y <= maxY - 1 {
                    if !rowCovers(y, minX, maxX) { ok = false; break }
                    y += 1
                }
                if ok {
                    maxArea = area
                }
            }
        }
        return maxArea
    }
    
    struct Tile: Hashable, CustomStringConvertible {
        let x: Int
        let y: Int
        
        var description: String {
            return "(\(x), \(y))"
        }
    }
}
