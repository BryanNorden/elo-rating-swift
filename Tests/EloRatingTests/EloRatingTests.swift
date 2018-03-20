import XCTest
@testable import EloRating

class EloRatingTests: XCTestCase {
    
    func testChanceOfWinningFor_100_vs_75() {
        let rating = EloRating().chanceOfWinning(forPlayer: 100.0, vs: 75.0)
        XCTAssertEqual(rating, 0.535, accuracy: 0.001)
    }
    
    func testChanceOfWinningFor_75_vs_100() {
        let rating = EloRating().chanceOfWinning(forPlayer: 75.0, vs: 100.0)
        XCTAssertEqual(rating, 0.464, accuracy: 0.001)
    }

    func testChanceOfWinningFor_1_And_10() {
        let rating = EloRating().chanceOfWinning(forPlayer: 1, vs: 10)
        XCTAssertEqual(rating, 0.487, accuracy: 0.001)
    }
    
    func testChanceOfWinningFor_10_And_1() {
        let rating = EloRating().chanceOfWinning(forPlayer: 10, vs: 1)
        XCTAssertEqual(rating, 0.512, accuracy: 0.001)
    }
    
    func testChanceOfWinning_sameRatings() {
        let rating = EloRating().chanceOfWinning(forPlayer: 1, vs: 1)
        XCTAssertEqual(rating, 0.500, accuracy: 0.001)
    }
    
    static var allTests = [
        ("testChanceOfWinningFor_100_vs_75", testChanceOfWinningFor_100_vs_75),
        ("testChanceOfWinningFor_75_vs_100", testChanceOfWinningFor_75_vs_100),
        ("testChanceOfWinningFor_1_And_10", testChanceOfWinningFor_1_And_10),
        ("testChanceOfWinningFor_10_And_1", testChanceOfWinningFor_10_And_1),
        ("testChanceOfWinning_sameRatings", testChanceOfWinning_sameRatings),
    ]
}
