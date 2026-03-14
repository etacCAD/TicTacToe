import SwiftUI

// MARK: - Game View Model

@MainActor
class GameViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var board: Board = Array(repeating: Array(repeating: nil, count: 3), count: 3)
    @Published var currentPlayer: Player = .x
    @Published var gameResult: GameResult = .ongoing
    @Published var gameMode: GameMode = .vsAI
    @Published var xWins: Int = 0
    @Published var oWins: Int = 0
    @Published var draws: Int = 0
    @Published var showResult: Bool = false
    @Published var winningCells: [(Int, Int)] = []
    @Published var isAIThinking: Bool = false
    
    // MARK: - Computed Properties
    
    var isGameOver: Bool {
        gameResult != .ongoing
    }
    
    var statusText: String {
        switch gameResult {
        case .win(let player):
            return "\(player.displayName) Wins!"
        case .draw:
            return "It's a Draw!"
        case .ongoing:
            if isAIThinking {
                return "AI is thinking..."
            }
            return "\(currentPlayer.displayName)'s Turn"
        }
    }
    
    // MARK: - Game Actions
    
    func makeMove(row: Int, col: Int) {
        guard board[row][col] == nil, !isGameOver else { return }
        guard !(gameMode == .vsAI && currentPlayer == .o && !isAIThinking) else { return }
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            board[row][col] = currentPlayer
        }
        
        if let result = checkGameResult() {
            endGame(result: result)
            return
        }
        
        currentPlayer = currentPlayer.next
        
        // Trigger AI move if in AI mode
        if gameMode == .vsAI && currentPlayer == .o && !isGameOver {
            triggerAIMove()
        }
    }
    
    func resetGame() {
        withAnimation(.easeInOut(duration: 0.3)) {
            board = Array(repeating: Array(repeating: nil, count: 3), count: 3)
            currentPlayer = .x
            gameResult = .ongoing
            showResult = false
            winningCells = []
            isAIThinking = false
        }
    }
    
    func resetScores() {
        xWins = 0
        oWins = 0
        draws = 0
        resetGame()
    }
    
    func changeGameMode(_ mode: GameMode) {
        gameMode = mode
        resetScores()
    }
    
    // MARK: - AI Logic
    
    private func triggerAIMove() {
        isAIThinking = true
        
        // Small delay to make it feel like the AI is "thinking"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.performAIMove()
        }
    }
    
    private func performAIMove() {
        guard gameMode == .vsAI, currentPlayer == .o, !isGameOver else {
            isAIThinking = false
            return
        }
        
        // Try to win first
        if let move = findBestMove(for: .o) {
            makeAIMove(row: move.0, col: move.1)
            return
        }
        
        // Try to block opponent
        if let move = findBestMove(for: .x) {
            makeAIMove(row: move.0, col: move.1)
            return
        }
        
        // Take center if available
        if board[1][1] == nil {
            makeAIMove(row: 1, col: 1)
            return
        }
        
        // Take a corner
        let corners = [(0, 0), (0, 2), (2, 0), (2, 2)].shuffled()
        for corner in corners {
            if board[corner.0][corner.1] == nil {
                makeAIMove(row: corner.0, col: corner.1)
                return
            }
        }
        
        // Take any available cell
        let emptyCells = getEmptyCells()
        if let cell = emptyCells.randomElement() {
            makeAIMove(row: cell.0, col: cell.1)
        }
        
        isAIThinking = false
    }
    
    private func makeAIMove(row: Int, col: Int) {
        isAIThinking = false
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            board[row][col] = .o
        }
        
        if let result = checkGameResult() {
            endGame(result: result)
            return
        }
        
        currentPlayer = .x
    }
    
    private func findBestMove(for player: Player) -> (Int, Int)? {
        for row in 0..<3 {
            for col in 0..<3 {
                if board[row][col] == nil {
                    board[row][col] = player
                    let wins = checkWin(for: player)
                    board[row][col] = nil
                    if wins {
                        return (row, col)
                    }
                }
            }
        }
        return nil
    }
    
    private func getEmptyCells() -> [(Int, Int)] {
        var cells: [(Int, Int)] = []
        for row in 0..<3 {
            for col in 0..<3 {
                if board[row][col] == nil {
                    cells.append((row, col))
                }
            }
        }
        return cells
    }
    
    // MARK: - Win/Draw Detection
    
    private func checkGameResult() -> GameResult? {
        // Check for win
        for player in Player.allCases {
            if checkWin(for: player) {
                return .win(player)
            }
        }
        
        // Check for draw
        let hasEmptyCell = board.flatMap { $0 }.contains(where: { $0 == nil })
        if !hasEmptyCell {
            return .draw
        }
        
        return nil
    }
    
    private func checkWin(for player: Player) -> Bool {
        // Rows
        for row in 0..<3 {
            if board[row].allSatisfy({ $0 == player }) {
                return true
            }
        }
        
        // Columns
        for col in 0..<3 {
            if (0..<3).allSatisfy({ board[$0][col] == player }) {
                return true
            }
        }
        
        // Diagonals
        if (0..<3).allSatisfy({ board[$0][$0] == player }) {
            return true
        }
        if (0..<3).allSatisfy({ board[$0][2 - $0] == player }) {
            return true
        }
        
        return false
    }
    
    private func findWinningCells(for player: Player) -> [(Int, Int)] {
        // Rows
        for row in 0..<3 {
            if board[row].allSatisfy({ $0 == player }) {
                return [(row, 0), (row, 1), (row, 2)]
            }
        }
        
        // Columns
        for col in 0..<3 {
            if (0..<3).allSatisfy({ board[$0][col] == player }) {
                return [(0, col), (1, col), (2, col)]
            }
        }
        
        // Diagonal top-left to bottom-right
        if (0..<3).allSatisfy({ board[$0][$0] == player }) {
            return [(0, 0), (1, 1), (2, 2)]
        }
        
        // Diagonal top-right to bottom-left
        if (0..<3).allSatisfy({ board[$0][2 - $0] == player }) {
            return [(0, 2), (1, 1), (2, 0)]
        }
        
        return []
    }
    
    // MARK: - Game End
    
    private func endGame(result: GameResult) {
        gameResult = result
        
        switch result {
        case .win(let player):
            winningCells = findWinningCells(for: player)
            if player == .x { xWins += 1 }
            else { oWins += 1 }
        case .draw:
            draws += 1
        case .ongoing:
            break
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                self?.showResult = true
            }
        }
    }
}
