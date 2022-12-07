//
//  EventRowView.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 27/11/2022.
//

import SwiftUI

struct EventRowView: View {
    
    @EnvironmentObject var vm: EventsCountdownViewModel
    
    let title: String
    let subtitle: String
    let bgColor: Int
    let icon: String
    let ddlDate: Date
    
    @State var optionSelected: Display.Options = .day
    @State var value = 0
    
    enum Display {
        
        enum Options {
            
            case day
            case hour
            case minute
        }
        
        static func optionView(optionSelected: Options, value: Int) -> AnyView {
            switch optionSelected {
                
            case .day:
                return AnyView(
                    VStack {
                        HStack {
                            Text("\(abs(value))")
                                .bold()
                            Text(abs(value) == 1 ? "day" : "days")
                                .bold()
                        }
                        if value < 0 {
                            Text("ago")
                        }
                    }
                )
            case .hour:
                return AnyView(
                    VStack {
                        Text("\(abs(value)) h")
                            .bold()
                        if value < 0 {
                            Text("ago")
                        }
                    }
                )
            case .minute:
                return AnyView(
                    VStack {
                        Text("\(abs(value)) m")
                            .bold()
                        if value < 0 {
                            Text("ago")
                        }
                    }
                )
                
            }
        }
        
    }
    
    
    var body: some View {
        ZStack {
      //      Color.black.ignoresSafeArea()

            HStack(alignment: .center) {
                img
                titleStack
                Spacer()
                
                VStack {
                    Display.optionView(optionSelected: optionSelected, value: value)
                }
                .onReceive(vm.timer) { _ in
                    updateTimeRemaining()
                }
            }
            .listRowSeparator(.hidden)
            .padding(.horizontal, 5)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(AddEditEventView.colors[bgColor])
            .cornerRadius(10)
        }
    }
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.day, .hour, .minute], from: Date(), to: ddlDate)
        
        let day = remaining.day ?? 0
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        
        
        if day != 0 {
            self.optionSelected = .day
            self.value = day
        } else if hour != 0 {
            self.optionSelected = .hour
            self.value = hour
        } else if minute != 0 {
            self.optionSelected = .minute
            self.value = minute
        }
        
    }

    
}

//struct EventRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventRowView(title: "Test", subtitle: "Test 2", bgColor: 2, icon: "star", ddlDate: Date())
//            .environmentObject(EventsCountdownViewModel())
//    }
//}

extension EventRowView {
    private var img: some View {
        Image(systemName: icon)
            .resizable()
            .frame(width: 50, height: 50)
    }
    
    private var titleStack: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title)
            
            Text(subtitle)
                .font(.subheadline)
        }
    }
}
