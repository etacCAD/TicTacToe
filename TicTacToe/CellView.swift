import SwiftUI

struct CellView: View {
    let player: Player?
    let isWinningCell: Bool
    let action: () -> Void
    
    @State private var isAnimating = false
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Cell background
                RoundedRectangle(cornerRadius: 12)
                    .fill(cellBackground)
                    .shadow(color: cellShadow, radius: isWinningCell ? 8 : 4, y: 2)
                
                // Player mark
                if let player = player {
                    Text(player.symbol)
                        .font(.system(size: 44, weight: .bold, design: .rounded))
                        .foregroundStyle(markGradient(for: player))
                        .scaleEffect(isAnimating ? 1.0 : 0.1)
                        .opacity(isAnimating ? 1.0 : 0.0)
                        .onAppear {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.55)) {
                                isAnimating = true
                            }
                        }
                }
            }
        }
        .buttonStyle(.plain)
        .aspectRatio(1, contentMode: .fit)
        .onChange(of: player) { oldValue, newValue in
            if newValue == nil {
                isAnimating = false
            }
        }
    }
    
    // MARK: - Styling
    
    private var cellBackground: some ShapeStyle {
        if isWinningCell {
            return AnyShapeStyle(
                LinearGradient(
                    colors: [
                        Color(red: 0.2, green: 0.85, blue: 0.6).opacity(0.3),
                        Color(red: 0.1, green: 0.7, blue: 0.5).opacity(0.2)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        return AnyShapeStyle(
            Color.white.opacity(0.05)
        )
    }
    
    private var cellShadow: Color {
        isWinningCell
            ? Color(red: 0.2, green: 0.85, blue: 0.6).opacity(0.3)
            : Color.black.opacity(0.2)
    }
    
    private func markGradient(for player: Player) -> LinearGradient {
        switch player {
        case .x:
            return LinearGradient(
                colors: [
                    Color(red: 0.4, green: 0.6, blue: 1.0),
                    Color(red: 0.6, green: 0.4, blue: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .o:
            return LinearGradient(
                colors: [
                    Color(red: 1.0, green: 0.5, blue: 0.5),
                    Color(red: 1.0, green: 0.35, blue: 0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

#Preview {
    HStack {
        CellView(player: .x, isWinningCell: false) {}
        CellView(player: .o, isWinningCell: true) {}
        CellView(player: nil, isWinningCell: false) {}
    }
    .padding()
    .background(Color(red: 0.08, green: 0.08, blue: 0.12))
}
