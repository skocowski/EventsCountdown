//
//  EventsCountdownViewModel.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 27/11/2022.
//

import Foundation
import CoreData
import SwiftUI

class EventsCountdownViewModel: ObservableObject {
    
    @Published var savedEvents = [EventEntity]()
    @Published var showPast = false
    
    let container: NSPersistentContainer

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        container = NSPersistentContainer(name: "EventsCountdown")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        fetchEvents(filter: showPast)
    }
    
    func fetchEvents(filter: Bool) {
        let request = NSFetchRequest<EventEntity>(entityName: "EventEntity")
        
        let sort = NSSortDescriptor(key: "ddlDate", ascending: true)
        
        let predicateFuture = NSPredicate(format: "ddlDate > %@ ", Date() as NSDate)
        let predicatePast = NSPredicate(format: "ddlDate < %@ ", Date() as NSDate)
        

        request.sortDescriptors = [sort]
        request.predicate = filter ? predicatePast : predicateFuture

        do {
            savedEvents = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching. \(error)")
        }
    }
    
    func addEvent(title: String, subtitle: String, selectedIndexColor: Int, icon: String, ddlDate: Date, isAllDay: Bool) {
        let newEvent = EventEntity(context: container.viewContext)
        newEvent.id = UUID()
        newEvent.title = title
        newEvent.subtitle = subtitle
        newEvent.selectedIndexColor = Int16(selectedIndexColor)
        newEvent.icon = icon
        newEvent.ddlDate = ddlDate
        newEvent.isAllDay = isAllDay

        
        saveData()
    }
    
    func updateEvent(entity: EventEntity, title: String, subtitle: String, selectedIndexColor: Int, icon: String, ddlDate: Date, isAllDay: Bool) {
        entity.title = title
        entity.subtitle = subtitle
        entity.selectedIndexColor = Int16(selectedIndexColor)
        entity.icon = icon
        entity.ddlDate = ddlDate
        entity.isAllDay = isAllDay
        
        saveData()
    }

    
    func deleteEvent(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEvents[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchEvents(filter: showPast)
        } catch {
            print("Error saving. \(error)")
        }
    }
    

}
