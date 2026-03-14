import SwiftUI

struct ScoreView: View {
    let xWins: Int
    let oWins: Int
    let draws: Int
    
    var body: some View {
        HStack(spacing: 0) {
            scoreItem(
                label: "X",
                value: xWins,
                gradient: LinearGradient(
                    colors: [
                        Color(red: 0.4, green: 0.6, blue: 1.0),
                        Color(red: 0.6, green: 0.4, blue: 1.0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            Spacer()
            
            scoreItem(
                label: "Draw",
                value: draws,
                gradient: LinearGradient(
                    colors: [
                        Color.white.opacity(0.6),
                        Color.white.opacity(0.4)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            Spacer()
            
            scoreItem(
                label: "O",
                value: oWins,
                gradient: LinearGradient(
                    colors: [
                        Color(red: 1.0, green: 0.5, blue: 0.5),
                        Color(red: 1.0, green: 0.35, blue: 0.6)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
        )
    }
    
    @ViewBuilder
    private func scoreItem(label: String, value: Int, gradient: LinearGradient) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(gradient)
            
            Text("\(value)")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(gradient)
                .contentTransition(.numericText())
        }
        .frame(minWidth: 60)
    }
}

#Preview {
    ScoreView(xWins: 3, oWins: 1, draws: 2)
        .padding()
        .background(Color(red: 0.08, green: 0.08, blue: 0.12))
}
