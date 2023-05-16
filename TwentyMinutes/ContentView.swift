//
//  ContentView.swift
//  TwentyMinutes
//
//  Created by Thomas Decrick on 15/05/2023.
//

import SwiftUI

struct CalendarMonthView: View {
    let calendar: Calendar = Calendar.current
    let month: Date

    var body: some View {
        LazyVGrid(columns: createGridColumns(), spacing: 10) {
            ForEach(0..<numberOfDaysInMonth(), id: \.self) { day in
                Text("\(day + 1)")
            }
        }
        .padding()
    }

    private func createGridColumns() -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 7)
    }

    private func numberOfDaysInMonth() -> Int {
        let range = calendar.range(of: .day, in: .month, for: month)!
        return range.count
    }
}


struct CalendarYearView: View {
    let calendar: Calendar = Calendar.current
    let startDate: Date
    let yearCount: Int

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 20) {
                ForEach(0..<yearCount) { index in
                    CalendarMonthView(month: calendar.date(byAdding: .month, value: index, to: startDate)!)
                        .id(index)
                }
            }
            .padding()
        }
    }
}

struct ContentView: View {
    var body: some View {
        CalendarYearView(startDate: Date(), yearCount: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
