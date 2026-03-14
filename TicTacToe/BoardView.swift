import SwiftUI

struct BoardView: View {
    @ObservedObject var viewModel: GameViewModel
    
    private let spacing: CGFloat = 8
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(0..<3, id: \.self) { col in
                        CellView(
                            player: viewModel.board[row][col],
                            isWinningCell: isWinningCell(row: row, col: col)
                        ) {
                            viewModel.makeMove(row: row, col: col)
                        }
                        .disabled(viewModel.isGameOver || viewModel.isAIThinking)
                    }
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.08),
                            Color.white.opacity(0.03)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
    
    private func isWinningCell(row: Int, col: Int) -> Bool {
        viewModel.winningCells.contains(where: { $0.0 == row && $0.1 == col })
    }
}

#Preview {
    BoardView(viewModel: GameViewModel())
        .padding()
        .background(Color(red: 0.08, green: 0.08, blue: 0.12))
}
