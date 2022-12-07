//
//  AddEventView.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 27/11/2022.
//

import SwiftUI


struct AddEditEventView: View {
    
    @EnvironmentObject var vm: EventsCountdownViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    var event: EventEntity?
    
    @State var isShowingIconsList = false
    @State var icon = "star"
    @State var title: String = ""
    @State var subtitle: String = ""
    
    @State var allDayEvent = false
    @State var ddlDate = Date()
    
    let columnsForColorList: [GridItem] = [
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50))
    ]
    static let colors: [Color] = [
        .red, .yellow, .orange, .purple, .blue, .indigo, .green, .mint, .cyan, .gray
    ]

    @State var selectedIndexColor = 0
    
    var body: some View {
 
        ZStack {
            Color.theme.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 30) {
                
                titleElement
                
                Toggle("All day event?", isOn: $allDayEvent)
                    .elementStyle()
                    .foregroundColor(Color.theme.whiteFont)


                dateElement
                colourList
                addEditButton
                Spacer()
            }

            .sheet(isPresented: $isShowingIconsList) { IconsListView(icon: $icon) }
        }
    }
}

struct AddEditEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddEditEventView()
                .environmentObject(EventsCountdownViewModel())
        }
    }
}

extension AddEditEventView {
    
    private var titleElement: some View {
        HStack(alignment: .center, spacing: 10) {
            Button {
                isShowingIconsList.toggle()
            } label: {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.blue)
            }


            VStack(spacing: 15) {

                ZStack(alignment: .leading) {
                    if title.isEmpty {
                        Text("Title")
                        
                        .foregroundColor(Color.gray)
                        
                    }
                    TextField("", text: $title)
                        .onReceive(title.publisher.collect()) {
                            title = String($0.prefix(20))
                        }
                    
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2) )
                   
                    .font(.title2)
                
                ZStack(alignment: .leading) {
                    if subtitle.isEmpty {
                        Text("Subtitle")
                     
                        .foregroundColor(Color.gray)
                        
                    }
                    TextField("", text: $subtitle)
                        .onReceive(subtitle.publisher.collect()) {
                            subtitle = String($0.prefix(25))
                        }
                    
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .font(.subheadline)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
            }
            .foregroundColor(.white)
            
        }
        .elementStyle()
    }
    
    private var dateElement: some View {
        HStack {
            
            Text("Date:")
                .font(.title)
                .foregroundColor(Color.theme.whiteFont)
            
            DatePicker("Date", selection: $ddlDate, in: Date()..., displayedComponents: allDayEvent ? [.date] : [.date, .hourAndMinute])
                .colorInvert()
                .labelsHidden()
                .tint(.green)
                .foregroundColor(Color.theme.whiteFont)

            Spacer()
        }
        .elementStyle()
    }
    
    private var colourList: some View {
        VStack {
            Text("Choose colour:")
                .font(.title)
                .foregroundColor(Color.theme.whiteFont)
            LazyVGrid(columns: columnsForColorList) {
                ForEach(Array(AddEditEventView.colors.enumerated()), id: \.offset) { index, color in
                        Circle()
                        .foregroundColor(color)
                        .frame(width: 45, height: 45)
                        .scaleEffect(index == selectedIndexColor ? 1.2 : 1.0)
                        .onTapGesture {
                            selectedIndexColor = index
                        }
                }
            }

        }
        .elementStyle()
    }
    
    private var addEditButton: some View {
        Button {
            guard !title.isEmpty else { return }
            if event != nil {
                vm.updateEvent(entity: event!, title: title, subtitle: subtitle, selectedIndexColor: selectedIndexColor, icon: icon, ddlDate: ddlDate, isAllDay: allDayEvent)
            } else {
                vm.addEvent(title: title, subtitle: subtitle, selectedIndexColor: selectedIndexColor, icon: icon, ddlDate: allDayEvent ? ddlDate.allDayDate() : ddlDate, isAllDay: allDayEvent)
            }
            
         

            dismiss()
        } label: {
            Text(event != nil ? "Edit Event" : "Add Event")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
        }
    }

}
