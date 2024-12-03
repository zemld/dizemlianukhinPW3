//
//  CalendarManager.swift
//  dizemlianukhinPW3
//
//  Created by Denis Zemlyanukhin on 02.12.2024.
//

import EventKit

protocol CalendarManaging {
    func create(eventModel: CalendarEventModel) -> Bool
}

struct CalendarEventModel: Codable {
    let eventTitle: String
    let eventNote: String?
    let eventStartDate: Date
    let eventEndDate: Date
}

final class CalendarManager: CalendarManaging {
    private let eventStore : EKEventStore = EKEventStore()
    
    func create(eventModel: CalendarEventModel) -> Bool {
        var result: Bool = false
        let group = DispatchGroup()
        group.enter()
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        group.wait()
        return result
    }
    
    func create(eventModel: CalendarEventModel, completion: ((Bool) -> Void)?) {
        let createEvent: EKEventStoreRequestAccessCompletionHandler = { [weak self] (granted,
                                                                                     error) in
            guard granted, error == nil, let self else {
                completion?(false)
                return
            }
            let event: EKEvent = EKEvent(eventStore: self.eventStore)
            event.title = eventModel.eventTitle
            event.startDate = eventModel.eventStartDate
            event.endDate = eventModel.eventEndDate
            event.notes = eventModel.eventNote
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            do {
                try self.eventStore.save(event, span: .thisEvent)
            } catch let error as NSError {
                print("failed to save event with error : \(error)")
                completion?(false)
            }
            completion?(true)
        }
        
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents(completion: createEvent)
        } else {
            eventStore.requestAccess(to: .event, completion: createEvent)
        }
    }
}
