//
//  ContentView.swift
//  ColorDiff
//
//  Created by Dan Lewis on 11/08/2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject
    var gameState = GameState()
    
    var body: some View {
        VStack {
            GameView(row: $gameState.rows, column: $gameState.cols, correctTile: $gameState.correctTile, color: $gameState.color, colorSimilarPercent: $gameState.colorSimilarPercent, onCorrect: gameState.updateLevel, onIncorrect: gameState.endGame)
            TimerView(level: $gameState.level, best: $gameState.best, progress: $gameState.timerProgress, startTime: gameState.timerStart)
//            Button {
//                gameState.updateLevel()
//            } label: {
//                Text("Debug: Increase Level")
//            }
//            Button("Debug: End Game") {
//                gameState.endGame()
//            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .onAppear {
            gameState.reset()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
