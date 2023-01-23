//
//  GameState.swift
//  ColorDiff
//
//  Created by Dan Lewis on 07/01/2023.
//

import Foundation
import SwiftUI

class GameState: ObservableObject {
    let colors = [Color.green, Color.yellow, Color.blue, Color.purple, Color.orange, Color.mint, Color.brown]
    
    @Published
    var best = 0
    @Published
    var level = 0
    @Published
    var cols = 5
    @Published
    var rows = 5
    @Published
    var correctTile = 0
    @Published
    var color = Color.red
    @Published
    var timerProgress = 0.0
    let timerStart = 5.0
    private let timerInterval = 0.1
    @Published
    var colorSimilarPercent = 0.0
    
    var timer: Timer?
    
    private let maxCols = 25
    private let maxRows = 30
    
    func updateLevel() {
        level += 1
        newLevel()
    }
    
    func createAndStartTimer() {
        timerProgress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func updateTimer() {
        timerProgress += (timerInterval / timerStart)
        guard timerProgress >= 1.0 else { return }
        
        endGame()
    }
    
    func endGame() {
        updateBest()
        reset()
    }
    
    func updateBest() {
        guard (level > best) else { return }
        best = level
    }
    
    func newLevel() {
        timer?.invalidate()
        createAndStartTimer()
        cols = calculateCols()
        rows = calculateRows()
        color = randomColor()
        correctTile = randomTile()
        colorSimilarPercent = calculateColorSimilarPercent()
    }
    
    func reset() {
        level = 0
        timerProgress = 0.0
        newLevel()
    }
    
    func calculateRows() -> Int {
        let value = Int((Double(self.level) * 0.8)) + 5
        guard value >= maxRows else { return value }
        return maxRows
    }
    
    func calculateCols() -> Int {
        let value = Int((Double(self.level) * 0.7) + 5)
        guard value >= maxCols else { return value }
        return maxCols
    }
    
    func randomTile() -> Int {
        var value = correctTile
        while (value == correctTile) {
            value = Int.random(in: 0..<(rows*cols))
        }
        return value
    }
    
    func randomColor() -> Color {
        var value = color
        while (value == color) {
            value = colors.randomElement()!
        }
        return value
    }
    
    func calculateColorSimilarPercent() -> Double {
        let value = 0.99 / pow(Double(level + 2), 0.5)
        return 1 + value
    }
    
}
