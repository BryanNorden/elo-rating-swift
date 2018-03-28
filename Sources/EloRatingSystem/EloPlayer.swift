import Foundation
import Vapor

public enum GameResult: Int {
    case lost = 0
    case won = 1
}

// To identify a player later use uuid or id depending on your user model

public final class EloPlayer: Codable {
    public var gameResult: GameResult
    public var ratingBefore: Double
    public var ratingAfter: Double
    public var ratingChange: Double
    public var uuid: UUID?
    public var id: Int?
    
    public enum CodingKeys: String, CodingKey {
        case gameResult
        case ratingBefore
        case ratingAfter
        case ratingChange
        case uuid
        case id
    }
    
    public init(gameResult: GameResult, ratingBefore: Double, ratingAfter: Double, ratingChange: Double, uuid: UUID? = nil, id: Int? = 0) {
        self.gameResult = gameResult
        self.ratingBefore = ratingBefore
        self.ratingAfter = ratingAfter
        self.ratingChange = ratingChange
        self.uuid = uuid
        self.id = id
    }
    
    required public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gameResult = GameResult(rawValue: try values.decode(Int.self, forKey: .gameResult))!
        ratingBefore = try values.decode(Double.self, forKey: .ratingBefore)
        ratingAfter = try values.decode(Double.self, forKey: .ratingAfter)
        ratingChange = try values.decode(Double.self, forKey: .ratingChange)
        uuid = try values.decode(UUID.self, forKey: .uuid)
        id = try values.decode(Int.self, forKey: .id)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gameResult.rawValue, forKey: .gameResult)
        try container.encode(ratingBefore, forKey: .ratingBefore)
        try container.encode(ratingAfter, forKey: .ratingAfter)
        try container.encode(ratingChange, forKey: .ratingChange)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(id, forKey: .id)
    }
}

extension EloPlayer: Content {}
