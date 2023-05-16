import SwiftUI

struct MonthView: View {
    let calendar: Calendar = Calendar.current
    let month: Date

    var body: some View {
        VStack {
            Text(monthTitle(for: month))
                .font(.largeTitle)

            LazyVGrid(columns: createGridColumns(), spacing: 10) {
                ForEach(0..<numberOfDaysInMonth(), id: \.self) { day in
                    Text("\(day + 1)")
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



struct InfiniteCalendarView: View {
    @State private var months = [Date()]
    private let calendar = Calendar.current

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(months.indices, id: \.self) { index in
                    MonthView(month: months[index])
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
        }
    }
}


struct ContentView: View {
    var body: some View {
        InfiniteCalendarView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

