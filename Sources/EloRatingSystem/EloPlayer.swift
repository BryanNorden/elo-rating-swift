import Foundation

public enum GameResult {
    case won
    case lost
}

// To identify a player later use uuid or id depending on your user model

public class EloPlayer: CustomStringConvertible {
    public var gameResult: GameResult
    public var ratingBefore: Double
    public var ratingAfter: Double
    public var ratingChange: Double
    public var uuid: UUID?
    public var id: Int?
    
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
