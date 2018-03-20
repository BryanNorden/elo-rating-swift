import Foundation

public struct EloRating {
  
    /**
     Chance of Winning for a player vs another player
     
     - parameters:
        - forPlayer: Player rating (Float)
        - vs: Rating (Float) of player you want to beat
     
     - returns:
     Decimal percentage change of player A beating player B
     
     - Note:
     chanceOfWinning = 1 / (1 + 10^((B - A)/400) )
    
     - seealso:
     [Elo Rating System](https://en.wikipedia.org/wiki/Elo_rating_system#Mathematical_details)
     */
    func chanceOfWinning(forPlayer ratingA: Float, vs ratingB: Float) -> Float {
        return 1 / (1 + pow(10,((ratingB - ratingA) / 400.0)))
    }

}
