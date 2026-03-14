import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 0.06, green: 0.06, blue: 0.10),
                    Color(red: 0.10, green: 0.08, blue: 0.16),
                    Color(red: 0.06, green: 0.06, blue: 0.10)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Subtle background circles
            backgroundDecoration
            
            VStack(spacing: 24) {
                // Title
                Text("Tic Tac Toe")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .white.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding(.top, 8)
                
                // Game mode picker
                gameModeSelector
                
                // Score display
                ScoreView(
                    xWins: viewModel.xWins,
                    oWins: viewModel.oWins,
                    draws: viewModel.draws
                )
                
                // Status text
                Text(viewModel.statusText)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(statusColor)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.statusText)
                
                // Game board
                BoardView(viewModel: viewModel)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                // Buttons
                buttonsSection
                
                Spacer()
            }
            .padding()
            
            // Result overlay
            if viewModel.showResult {
                resultOverlay
            }
        }
    }
    
    // MARK: - Game Mode Selector
    
    private var gameModeSelector: some View {
        HStack(spacing: 4) {
            ForEach(GameMode.allCases, id: \.rawValue) { mode in
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        viewModel.changeGameMode(mode)
                    }
                } label: {
                    Text(mode.rawValue)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(viewModel.gameMode == mode ? .white : .white.opacity(0.5))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(viewModel.gameMode == mode
                                      ? Color.white.opacity(0.15)
                                      : Color.clear)
                        )
                }
            }
        }
        .padding(4)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.05))
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Buttons
    
    private var buttonsSection: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.resetGame()
            } label: {
                Label("New Game", systemImage: "arrow.counterclockwise")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.3, green: 0.5, blue: 0.9),
                                        Color(red: 0.5, green: 0.3, blue: 0.9)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: Color(red: 0.4, green: 0.4, blue: 0.9).opacity(0.4), radius: 8, y: 4)
                    )
            }
            
            Button {
                viewModel.resetScores()
            } label: {
                Label("Reset All", systemImage: "trash")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.08))
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
                            )
                    )
            }
        }
    }
    
    // MARK: - Result Overlay
    
    private var resultOverlay: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.resetGame()
                }
            
            VStack(spacing: 20) {
                // Result icon
                Group {
                    switch viewModel.gameResult {
                    case .win(let player):
                        Text(player.symbol)
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                            .foregroundStyle(player == .x
                                ? LinearGradient(colors: [Color(red: 0.4, green: 0.6, blue: 1.0), Color(red: 0.6, green: 0.4, blue: 1.0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                : LinearGradient(colors: [Color(red: 1.0, green: 0.5, blue: 0.5), Color(red: 1.0, green: 0.35, blue: 0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                    case .draw:
                        Image(systemName: "equal.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.7))
                    case .ongoing:
                        EmptyView()
                    }
                }
                
                Text(viewModel.statusText)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Button {
                    viewModel.resetGame()
                } label: {
                    Text("Play Again")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 0.3, green: 0.5, blue: 0.9),
                                            Color(red: 0.5, green: 0.3, blue: 0.9)
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: Color(red: 0.4, green: 0.4, blue: 0.9).opacity(0.5), radius: 12, y: 4)
                        )
                }
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.12, green: 0.12, blue: 0.18),
                                Color(red: 0.08, green: 0.08, blue: 0.14)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.5), radius: 30, y: 10)
            )
            .transition(.scale.combined(with: .opacity))
        }
    }
    
    // MARK: - Decorations
    
    private var backgroundDecoration: some View {
        GeometryReader { geo in
            Circle()
                .fill(Color(red: 0.3, green: 0.4, blue: 0.9).opacity(0.08))
                .frame(width: 300, height: 300)
                .blur(radius: 60)
                .offset(x: -50, y: -100)
            
            Circle()
                .fill(Color(red: 0.8, green: 0.3, blue: 0.5).opacity(0.06))
                .frame(width: 250, height: 250)
                .blur(radius: 50)
                .offset(x: geo.size.width - 150, y: geo.size.height - 300)
        }
    }
    
    // MARK: - Helpers
    
    private var statusColor: Color {
        switch viewModel.gameResult {
        case .win: return Color(red: 0.2, green: 0.85, blue: 0.6)
        case .draw: return .white.opacity(0.6)
        case .ongoing: return .white.opacity(0.8)
        }
    }
}

#Preview {
    ContentView()
}
