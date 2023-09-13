import SwiftUI
@available(iOS 16.0, *)
struct CalendarView:UIViewRepresentable{
    let interval:DateInterval
    @ObservedObject var events:CalendarEventManager
    @EnvironmentObject var sharing:SharedValues
    @EnvironmentObject var chartVM:ChartViewModel
    @State var calEvent:[CalendarEventStruct]?
    @State var calendarView:UICalendarView?
    func makeUIView(context: Context) -> UICalendarView {
        
        events.generateEvents(viewModel: chartVM, sharing: sharing)
        
        
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        view.calendar.locale = Locale.current
        view.delegate = context.coordinator
        
        let dataSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dataSelection
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.calendarView = view
            var dates:[DateComponents] = []
            for myEvent in events.events{
                dates.append(myEvent.dateComponents)
            }
            
            self.calendarView?.reloadDecorations(forDateComponents: dates, animated: true)
        }
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coodinator {
        return Coodinator(self, _events)
    }
    
    class Coodinator:NSObject,UICalendarViewDelegate,UICalendarSelectionSingleDateDelegate{
        
        @ObservedObject var events:CalendarEventManager
        
        
        init(_ parent: CalendarView, _ events:ObservedObject<CalendarEventManager>) {
            self.parent = parent
            self._events = events
        }
        
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {

        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
        
        
        var parent:CalendarView
        
      
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let foundEvents = events.events
            for event in foundEvents {
                if event.date.startOfDay == dateComponents.date?.startOfDay{
                    return.customView {
                        
                        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
                        
                        
                        let colorView = UIView(frame: rect)
                        colorView.backgroundColor = .red
                        
                        
                        let text = UILabel()
                        text.textColor = .black
                        let formatter = DateFormatter()
                        formatter.dateStyle = .short
                        text.text =  formatter.string(from: event.date)
                        text.font = text.font.withSize(6)
                        
                        colorView.addSubview(text)
                        return colorView
                        
                        
                        
                        
                    }
                    
                }
            }
            if foundEvents.isEmpty{ return nil }
            let singleEvent = foundEvents.first!
            
            return nil
            
        }
    }
    
    
    
    
}

