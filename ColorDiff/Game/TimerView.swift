//
//  TimerView.swift
//  ColorDiff
//
//  Created by Dan Lewis on 11/08/2022.
//

import SwiftUI

struct TimerView: View {
    let color = Color.primary
    
    @Binding
    var level: Int
    @Binding
    var best: Int
    @Binding
    var progress: Double
    let startTime: Double
    
    var body: some View {
        HStack {
            Spacer()
            LevelView(level: $level)
            Spacer()
            ZStack{
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(color)
                Circle()
                    .trim(from: 0.0, to: self.progress)
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .rotation(Angle.degrees(270))
                    .foregroundColor(color)
                Text(String(format: "%.0f", startTime - min(self.progress, 1.0) * startTime))
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.primary)
            }
            .frame(width: 50, height: 50)
            .padding()
            Spacer()
            BestView(best: $best)
            Spacer()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(level: .constant(1), best: .constant(0), progress: .constant(0.5), startTime: 5)
            .previewLayout(.sizeThatFits)
    }
}
