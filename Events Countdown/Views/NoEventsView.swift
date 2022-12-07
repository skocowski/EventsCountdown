//
//  NoEventsView.swift
//  Events Countdown
//
//  Created by Szymon Kocowski on 04/12/2022.
//

import SwiftUI

struct NoEventsView: View {
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
                    Text("No events")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.theme.whiteFont)
                    Text("Press the button to add a new event.")
                        .padding(.bottom, 20)
                        .foregroundColor(Color.theme.whiteFont)
                    
                    NavigationLink(destination: AddEditEventView()) {
                        Text("Add event")
                            .foregroundColor(Color.theme.whiteFont)
                            .font(.title2)
                            .bold()
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, animate ? 30 : 50)
                    .shadow(
                        color: .red.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0.0,
                        y: animate ? 50 : 30)
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                }
                .frame(maxWidth: 400)
                .multilineTextAlignment(.center)
                .padding(40)
                .onAppear(perform: addAnimation)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
                
            ) {
                animate.toggle()
            }
        }
    }
}

struct NoEventsView_Previews: PreviewProvider {
    static var previews: some View {
        NoEventsView()
    }
}
