//
//  FilteredList.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 02/12/2022.
//


import SwiftUI
import CoreData

struct FilteredListView: View {
    
    @EnvironmentObject var vm: EventsCountdownViewModel
    
    var body: some View {
        ZStack {
            
            if !vm.savedEvents.isEmpty {
                List {
                    ForEach(vm.savedEvents) { event in
                        
                        let title = event.title ?? ""
                        let subtitle = event.subtitle ?? ""
                        let bgColor = Int(event.selectedIndexColor)
                        let icon = event.icon ?? "star"
                        let ddlDate = event.ddlDate ?? Date()
                        let selectedIndexColor = Int(event.selectedIndexColor)
                        let isAllDay = event.isAllDay
                        
                        EventRowView(title: title, subtitle: subtitle, bgColor: bgColor, icon: icon, ddlDate: ddlDate)
                            .padding(.vertical, -5)
                            .overlay(
                                NavigationLink {
                                    AddEditEventView(event: event, icon: icon, title: title, subtitle: subtitle, allDayEvent: isAllDay, ddlDate: ddlDate, selectedIndexColor: selectedIndexColor)
                                } label: { EmptyView() }.opacity(0.0)
                            )

                    }
                    .onDelete(perform: vm.deleteEvent)
                    .listRowBackground(Color.theme.background)
                    
                    
                }
                .padding(.horizontal, -20)
                .listStyle(.plain)
            } else {
                NoEventsView()
            }
        }

    }
}



//struct FilteredListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}


