//
//  CalendarEvents.swift
//  PersonalHoroscope
//
//  Created by William Seele on 2023/9/11.
//

import Foundation
import CoreLocation


class CalendarEventManager:ObservableObject{
    
    @Published var events:[CalendarEventStruct] = []
    let calendarEndDays = 7
    func generateEvents(viewModel:ChartViewModel, sharing:SharedValues){
        DispatchQueue.main.asyncAfter(deadline: .now()){
          self.events = []
          
            
          let currentTime = Date()
            
          var myId = 0
            
          for i in 0...calendarEndDays{
            
            let idx = calendarEndDays - i
                
              //...    
              //...
              //...
              //... 
              self.events.append(CalendarEventStruct(id: myId, date: sharing.eventTime, eventData: viewModel.processedEventData))
              
              myId += 1

                
          
          }
        
        }
        
    }
 
    
    
}
