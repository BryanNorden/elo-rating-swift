# EloRatingSystem

This is an Elo rating system built using Swift. It has win estimation and rating calculations for an unlimited amount of players. The rating calculator can handle games for 1 vs 1, 2 vs 2, 3 vs 100 or etc. It will provide you with the chance of winning as a percentage for player A versus player B.

# Install with Swift Package Manager

1. Open your Package.swift file and add this to your package dependancies:

`.package(url: "https://github.com/BryanNorden/elo-rating-swift.git", from: "1.2.0"`

2. In Package.swift find main target and add `"EloRatingSystem"`

3. Add this to any file where you would like to use the rating system: 
`import EloRatingSystem`
4. Build / Run, then enjoy

### Notes
- To update the package manually open terminal and run  `swift package update`

- If you have issues you can run this in termial to reset your packages
`rm -rf .build/ *.xcodeproj/ Package.resolved`

# Calculate the chance of winning
`EloRating().chanceOfWinning(forPlayer: 100.0, vs: 1.0)` ->  chance of winning as a percentage in decimal form

### Chance of winning Example
We have two players. Bob with a rating of 800 and Jake with a rating of 1500.

To find out the likely hood that Bob will beat Jake you would use this
`let chanceOfBobBeatingJake = chanceOfWinning(forPlayer 800, vs ratingB: 1500)`
Then chanceOfBobBeatingJake = 0.17472092062234879 or 17.5% chance Bob will beat Jake

The chance of Jake beating Bob would be 
`let chanceOfJakeBeatingBob = chanceOfWinning(forPlayer 1500, vs ratingB: 800)`
So chanceOfJakeBeatingBob = 0.98252791166305542 or 98.25% chance Jake will beat Bob

# Calculate Ratings after Game has been played
`EloRating().calculateWinLossRatings(_ players: [EloPlayer])`
This will take an array of EloPlayers and will return back an array of EloPlayers with their updated rating. You will need to create an EloPlayer for each of the players that played. The EloPlayer is just for that game. You can use your own player models. 

**Important:** EloPlayer has an optional property id and uuid to help you identify your user. The function will work if you do not assign the EloPlayer your user's id or uuid, but it will be harder to identify your user when the rating calculations are returned

The players will be sorted into a winning team vs losing team based on the game result you assign the player (This is how it can handle any amounts of players). Then it will calculate the rating for everyone based on the ratings each player had before the start of the game. So you would then update your player model with their new rating, which would be `EloPlayer.ratingAfter`

#### Example of how to use calculateWinLossRatings method
```
let players = [
EloPlayer(gameResult: .won, ratingBefore: 900, ratingAfter: 0, ratingChange: 0, id: 112),
EloPlayer(gameResult: .won, ratingBefore: 600, ratingAfter: 0, ratingChange: 0, id: 200),
EloPlayer(gameResult: .lost, ratingBefore: 1500, ratingAfter: 0, ratingChange: 0, id: 6),
EloPlayer(gameResult: .lost, ratingBefore: 1100, ratingAfter: 0, ratingChange: 0, id: 22),
EloPlayer(gameResult: .lost, ratingBefore: 1100, ratingAfter: 0, ratingChange: 0, id: 56)
\]

let calculatedPlayers = EloRating().calculateWinLossRatings(players)
```

This would return these players
```
calculatedPlayers = [
EloPlayer(gameResult: .won, ratingBefore: 900, ratingAfter: 943.9107, ratingChange: 43.9107, id: 112),
EloPlayer(gameResult: .won, ratingBefore: 600, ratingAfter: 647.1034, ratingChange: 47.1034, id: 200),
EloPlayer(gameResult: .lost, ratingBefore: 1500, ratingAfter: 1468.2899, ratingChange: -31.7100, id: 6),
EloPlayer(gameResult: .lost, ratingBefore: 1100, ratingAfter: 1070.3479, ratingChange: -29.6520, id: 22),
EloPlayer(gameResult: .lost, ratingBefore: 1100, ratingAfter: 1070.3479, ratingChange: -29.6520, id: 56)
]
```
