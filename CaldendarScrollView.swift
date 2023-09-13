import SwiftUI

struct CalendarScrollView: View {
    @EnvironmentObject var sharing:SharedValues
    @EnvironmentObject var chartVM:ChartViewModel
    @EnvironmentObject var calendarEvent:CalendarEventManager
    var body: some View {
        ScrollView{
            CalendarView(interval: DateInterval(start:Date().addingTimeInterval(TimeInterval(-60 * 60 * 24 * calendarStartDays)),
                                                end: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * calendarEndDays))),
                         events:calendarEvent)
            .environmentObject(sharing)
            .environmentObject(chartVM)

        }
       
    }
}

struct CalendarScrollView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScrollView()
    }
}
