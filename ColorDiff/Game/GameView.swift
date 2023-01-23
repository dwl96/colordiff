//
//  GameView.swift
//  ColorDiff
//
//  Created by Dan Lewis on 11/08/2022.
//

import SwiftUI

struct GameView: View {
    @Binding
    var row: Int
    @Binding
    var column: Int
    @Binding
    var correctTile: Int
    @Binding
    var color: Color
    @Binding
    var colorSimilarPercent: Double
    
    let onCorrect: ()->()
    let onIncorrect: ()->()
    
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<column, id: \.self) { i in
                VStack(spacing: 1) {
                    ForEach(0..<row, id: \.self) { j in
                        let id = i + j * column
                        Rectangle()
                            .foregroundColor(id == correctTile ? generateSimilarColor(color) : color)
                            .onTapGesture {
                                if (id == correctTile) {
                                    onCorrect()
                                    return
                                }
                                onIncorrect()
                            }
                    }
                }

            }
        }
        .padding(5)
        .background(Color.primary)
        .cornerRadius(5)
    }
    
    
    
    func generateSimilarColor(_ color: Color) -> Color {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0
        
        UIColor(color).getRed(&r, green: &g, blue: &b, alpha: &o)
        
        return Color(red: r * colorSimilarPercent, green: g * colorSimilarPercent, blue: b * colorSimilarPercent)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(row: .constant(10), column: .constant(10), correctTile: .constant(10), color: .constant(Color.red), colorSimilarPercent: .constant(0.75), onCorrect: {}, onIncorrect: {})
            .previewLayout(.sizeThatFits)
    }
}
