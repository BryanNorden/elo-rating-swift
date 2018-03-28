import XCTest
import Foundation
@testable import EloRatingSystem

class EloRatingSystemTests: XCTestCase {
    
    // MARK: - Chance of Winning Tests
    
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
    
    // MARK: - Calculate Ratings Tests
    
    func testCalculateWinLossRatings() {
        let players: [EloPlayer] = [
            EloPlayer(gameResult: .won, ratingBefore: 900, ratingAfter: 0, ratingChange: 0),
            EloPlayer(gameResult: .won, ratingBefore: 600, ratingAfter: 0, ratingChange: 0),
            EloPlayer(gameResult: .lost, ratingBefore: 1500, ratingAfter: 0, ratingChange: 0),
            EloPlayer(gameResult: .lost, ratingBefore: 1100, ratingAfter: 0, ratingChange: 0),
            EloPlayer(gameResult: .lost, ratingBefore: 1100, ratingAfter: 0, ratingChange: 0)
            ]
        
        let playersAfterCaluclation = EloRating().calculateWinLossRatings(players)
        
        let expectedPlayers: [EloPlayer] = [
            EloPlayer(gameResult: .won, ratingBefore: 900, ratingAfter: 943.9107, ratingChange: 0),
            EloPlayer(gameResult: .won, ratingBefore: 600, ratingAfter: 647.1034, ratingChange: 0),
            EloPlayer(gameResult: .lost, ratingBefore: 1500, ratingAfter: 1468.2899, ratingChange: 0),
            EloPlayer(gameResult: .lost, ratingBefore: 1100, ratingAfter: 1070.3479, ratingChange: 0),
            EloPlayer(gameResult: .lost, ratingBefore: 1100, ratingAfter: 1070.3479, ratingChange: 0)
            ]

        for (index, _) in players.enumerated() {
            let expectedRating = expectedPlayers[index].ratingAfter
            let ratingAfter = playersAfterCaluclation[index].ratingAfter
            XCTAssertEqual(ratingAfter, expectedRating, accuracy: 0.0001)
        }
    }
    
    // MARK: - Test Helper
    
    static var allTests = [
        ("testChanceOfWinningFor_100_vs_75", testChanceOfWinningFor_100_vs_75),
        ("testChanceOfWinningFor_75_vs_100", testChanceOfWinningFor_75_vs_100),
        ("testChanceOfWinningFor_1_And_10", testChanceOfWinningFor_1_And_10),
        ("testChanceOfWinningFor_10_And_1", testChanceOfWinningFor_10_And_1),
        ("testChanceOfWinning_sameRatings", testChanceOfWinning_sameRatings),
        ("testCalculateWinLossRatings", testCalculateWinLossRatings)
    ]
}
