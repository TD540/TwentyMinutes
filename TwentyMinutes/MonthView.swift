//
//  MonthView.swift
//  TwentyMinutes
//
//  Created by Thomas Decrick on 16/05/2023.
//

import SwiftUI

struct MonthView: View {
    let calendar: Calendar = Calendar.current
    let month: Date

    var body: some View {
        VStack {
            Text(monthTitle(for: month))
                .font(.title)

            LazyVGrid(columns: createGridColumns(), spacing: 10) {
                ForEach(0..<numberOfDaysInMonth(), id: \.self) { day in
                    Button(("\(day + 1)")) {

                    }
                    
                }
            }
            .padding()
        }
    }

    private func createGridColumns() -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 7)
    }

    private func numberOfDaysInMonth() -> Int {
        let range = calendar.range(of: .day, in: .month, for: month)!
        return range.count
    }

    private func monthTitle(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(month: Date())
    }
}
