//
//  InfiniteCalendarView.swift
//  TwentyMinutes
//
//  Created by Thomas Decrick on 16/05/2023.
//

import SwiftUI

struct InfiniteCalendarView: View {
    @State private var months: [Date]
    private let calendar = Calendar.current

    init() {
        var date = Date()
        var months = [Date]()
        for _ in 1...24 {
            months.insert(date, at: 0)
            date = calendar.date(byAdding: .month, value: -1, to: date)!
        }
        _months = State(initialValue: months)
    }

    var body: some View {
        ScrollView {
            ScrollViewReader { value in
                LazyVStack {
                    ForEach(months.indices, id: \.self) { index in
                        VStack {
                            MonthView(month: months[index])
                        }
                        .id(months[index])
                        .onAppear {
                            if index == months.count - 1 {
                                let nextMonth = calendar.date(byAdding: .month, value: 1, to: months[index])!
                                months.append(nextMonth)
                            } else if index == 0 {
                                let previousMonth = calendar.date(byAdding: .month, value: -1, to: months[index])!
                                months.insert(previousMonth, at: 0)
                            }
                        }
                    }
                }
                .onAppear {
                    value.scrollTo(months.first(where: { isCurrentMonth(date: $0) }), anchor: .top)
                }
            }
        }
    }

    private func isCurrentMonth(date: Date) -> Bool {
        let currentComponents = calendar.dateComponents([.year, .month], from: Date())
        let dateComponents = calendar.dateComponents([.year, .month], from: date)
        return currentComponents.year == dateComponents.year && currentComponents.month == dateComponents.month
    }
}

struct InfiniteCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteCalendarView()
    }
}
