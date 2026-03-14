import Foundation

// MARK: - Player

enum Player: String, CaseIterable {
    case x = "X"
    case o = "O"
    
    var next: Player {
        self == .x ? .o : .x
    }
    
    var symbol: String {
        rawValue
    }
    
    var displayName: String {
        switch self {
        case .x: return "Player X"
        case .o: return "Player O"
        }
    }
}

// MARK: - Game Mode

enum GameMode: String, CaseIterable {
    case vsAI = "vs AI"
    case vsFriend = "vs Friend"
}

// MARK: - Game Result

enum GameResult: Equatable {
    case win(Player)
    case draw
    case ongoing
}

// MARK: - Move

struct Move {
    let row: Int
    let col: Int
    let player: Player
}

// MARK: - Board Type

typealias Board = [[Player?]]
