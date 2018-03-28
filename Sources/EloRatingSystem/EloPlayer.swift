import Foundation

public enum GameResult {
    case won
    case lost
}

// To identify a player later use uuid or id depending on your user model

public class EloPlayer: CustomStringConvertible {
    var gameResult: GameResult
    var ratingBefore: Double
    var ratingAfter: Double
    var ratingChange: Double
    var uuid: UUID?
    var id: Int?
    
    public init(gameResult: GameResult, ratingBefore: Double, ratingAfter: Double, ratingChange: Double, uuid: UUID? = nil, id: Int? = 0) {
        self.gameResult = gameResult
        self.ratingBefore = ratingBefore
        self.ratingAfter = ratingAfter
        self.ratingChange = ratingChange
        self.uuid = uuid
        self.id = id
    }
}

// For better description when you want to print to console

extension CustomStringConvertible {
    public var description: String {
        var description = "\n**** \(type(of: self)) ****:\n"
        let selfMirror = Mirror(reflecting: self)
        
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "* \(propertyName): \(child.value)\n"
            }
        }
        
        return description
    }
}
