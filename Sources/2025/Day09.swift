import Foundation

struct Day09: AdventOfCodeDay {
    var title = "Movie Theater"
    var redTiles: [Tile] = []
    var greenTiles: [Tile] = []

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
                    greenTiles.append(Tile(x: tileA.x, y: j))
                }
            }
            
            if connectedByRow {
                for j in lowerCoord...higherCoord {
                    greenTiles.append(Tile(x: j, y: tileA.y))
                }
            }
        }
        
        // combine red and green tiles
        let allYValues = Set(greenTiles.map { $0.y }).sorted()
        for y in allYValues {
            let allXValuesInRow = Set(greenTiles.filter{ $0.y == y}.map { $0.x }.sorted())
            let minXValue = allXValuesInRow.min()!
            let maxXValue = allXValuesInRow.max()!
            for x in minXValue...maxXValue {
                guard !allXValuesInRow.contains(x) else { continue }
                greenTiles.append(Tile(x: x, y: y))
            }
        }
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
        for i in 0..<redTiles.count {
            for j in (i+1)..<redTiles.count {
                let deltaX = abs(redTiles[i].x - redTiles[j].x)
                let deltaY = abs(redTiles[i].y - redTiles[j].y)
                let area = (deltaX + 1) * (deltaY + 1)
                if area > maxArea {
                    
                    var allCoords: [Tile] = []
                    let minX = min(redTiles[i].x, redTiles[j].x)
                    let maxX = max(redTiles[i].x, redTiles[j].x)
                    let minY = min(redTiles[i].y, redTiles[j].y)
                    let maxY = max(redTiles[i].y, redTiles[j].y)
                    for x in minX...maxX {
                        for y in minY...maxY {
                            allCoords.append(Tile(x: x, y: y))
                        }
                    }
                    
                    
                    if allCoords.allSatisfy({ tile in
                        greenTiles.contains(where: { $0 == tile })
                    }) {
                        maxArea = area
                    }
                   
                }
            }
        }
        return maxArea
    }
    
    struct Tile: Equatable, CustomStringConvertible {
        let x: Int
        let y: Int
        
        var description: String {
            return "(\(x), \(y))"
        }
    }
}

