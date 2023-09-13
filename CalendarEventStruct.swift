
import Foundation
struct CalendarEventStruct:Identifiable{
    var id:Int
    var date:Date
    var eventData:[EventDataStruct]
    
    var dateComponents:DateComponents{
        var dateComponents = Calendar.current.dateComponents([.month,.day,.year,.hour,.minute], from: date)
        
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    
    init(id:Int, date:Date, eventData:[EventDataStruct]){
        self.id = id
        self.date = date
        self.eventData = eventData
    }
}
