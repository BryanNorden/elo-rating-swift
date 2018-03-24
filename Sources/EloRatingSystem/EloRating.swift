import Foundation

// Note: Used fromulas from https://en.wikipedia.org/wiki/Elo_rating_system#Mathematical_details and other online resources

class EloRating {
  
    /**
     Chance of Winning for a player vs another player
     
     - parameters:
        - forPlayer: Player rating (Float)
        - vs: Rating (Float) of player you want to beat
     
     - returns:
     Decimal percentage change of player A beating player B
     */
    public func chanceOfWinning(forPlayer ratingA: Float, vs ratingB: Float) -> Float {
        return 1 / (1 + pow(10,((ratingB - ratingA) / 400.0)))
    }
    
    /**
     Takes in an array of EloPlayers, calculates their rating, and sends an updated array of EloPlayers back
     
     - parameters:
     - players: Array of EloPlayers
     
     - returns:
     Array of EloPlayers with an updated ratingAfter
     */
    public func calculateWinLossRatings(_ players: [EloPlayer]) -> [EloPlayer] {

        // Filter games by won or lost
        let playersWhoWon = players.filter { $0.gameResult == .won}
        let playersWhoLost = players.filter { $0.gameResult == .lost}
        
        // Make a backup for the second rating process down below
        let playersWhoWonOriginal = playersWhoWon
        let playersWhoLostOriginal = playersWhoLost
        
        let K = 32 / Double(players.count - 1)
        
        // Calculate winner ratings
        for (playersWonIndex, _) in playersWhoWon.enumerated() {
            let winner = playersWhoWon[playersWonIndex]
            let winnerELO  = winner.ratingBefore
            
            for (playersLostIndex, _) in playersWhoLost.enumerated() {
                let loserELO = playersWhoLost[playersLostIndex].ratingBefore
                
                var S : Double
                
                if winnerELO < loserELO {
                    S = 2;
                } else if winnerELO == loserELO {
                    S = 0.5;
                } else {
                    S = 1.0;
                }
                
                let EA = 1 / (1.0 + pow(10.0, Double(loserELO - winnerELO) / 400.0))
                
                // Calculate ELO change vs this one opponent and add it to our rating change
                winner.ratingChange += K * (S - EA)
            }

            // Add accumulated change to initial ELO for final ELO
            winner.ratingAfter = winner.ratingBefore + winner.ratingChange
        }
        
        // Calculate loser ratings
        for (playersLostIndex, _) in playersWhoLostOriginal.enumerated() {
            let loser = playersWhoLostOriginal[playersLostIndex]
            let loserELO   = loser.ratingBefore
            
            for (playersWonIndex, _) in playersWhoWonOriginal.enumerated(){
                let winnerELO = playersWhoWonOriginal[playersWonIndex].ratingBefore
                
                var S : Double

                if loserELO < winnerELO {
                    S = 0;
                } else if loserELO == winnerELO {
                    S = -0.5;
                } else {
                    S = -1.0;
                }
                
                let EA = 1 / (1.0 + pow(10.0, Double(winnerELO - loserELO) / 400.0))
                
                // Calculate ELO change vs this one opponent and add it to our rating change
                loser.ratingChange += K * (S - EA)
            }

            // Add accumulated change to initial ELO for final ELO
            loser.ratingAfter = loser.ratingBefore + loser.ratingChange
        }
        
        return playersWhoWon + playersWhoLost
    }
    
    public init() {}
}
