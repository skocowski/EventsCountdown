//
//  MainView.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 27/11/2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: EventsCountdownViewModel
    @Environment(\.managedObjectContext) var moc
    
    init() {
        
        // Navigation Bar Title font colour.
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
    
        
        
        // Segmented picker colours
        let uiSegmentedControl = UISegmentedControl.appearance()
        uiSegmentedControl.backgroundColor = .systemFill
        uiSegmentedControl.selectedSegmentTintColor = .systemBlue
        uiSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        uiSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }

    
    var body: some View {
    
            if #available(iOS 16.0, *) {
                NavigationStack {
                    ZStack {
                        Color.theme.background.ignoresSafeArea()

                        VStack {
                            pickerSelection
                            FilteredListView()
                        }
                    }
                    .navigationTitle("Events Countdown")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink { AddEditEventView() } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(Color(.red))
                            }
                        }
                    }


                }
            } else {
                // Fallback on earlier versions
                NavigationView {
                    ZStack {
                        Color.theme.background.ignoresSafeArea()

                        VStack {
                            pickerSelection
                            FilteredListView()
                        }
                    }
                    .navigationTitle("Events Countdown")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink { AddEditEventView() } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(Color(.red))
                            }
                        }
                    }
                }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(EventsCountdownViewModel())
    }
}

extension MainView {
    
    private var pickerSelection: some View {
        Picker("Select", selection: $vm.showPast) {
            Text("Future").tag(false)
            Text("Past").tag(true)
        }
        .onChange(of: vm.showPast, perform: { newValue in
            withAnimation {
                vm.fetchEvents(filter: newValue)
            }
            
        })
        .pickerStyle(.segmented)
        .padding(.bottom, 10)
    }
}
