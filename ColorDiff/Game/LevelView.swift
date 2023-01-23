//
//  ScoreView.swift
//  ColorDiff
//
//  Created by Dan Lewis on 11/08/2022.
//

import SwiftUI

struct ValueView: View {
    let title: String
    @Binding var value: Int
    let color: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.callout)
            Text("\(value)")
                .font(.title)
                .fontWeight(.heavy)
        }
        .foregroundColor(Color.primary)
        .padding(5)
        .background(color)
        .cornerRadius(10)
    }
}

struct LevelView: View {
    @Binding var level: Int
    var body: some View {
        ValueView(title: "Score", value: $level, color: Color.green)
    }
}

struct BestView: View {
    @Binding var best: Int
    var body: some View {
        ValueView(title: "Best", value: $best, color: Color.yellow)
    }
}

struct ValueView_Previews: PreviewProvider {
    static var previews: some View {
        ValueView(title: "Level", value: .constant(1000), color: Color.red)
            .previewLayout(.sizeThatFits)
    }
}
