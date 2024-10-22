//
//  ContentView.swift
//  RXHackthon
//
//  Created by Abrar Ghandurah on 18/04/1446 AH.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action:{
                do {
                    deleteAllActitivites()
                    
                    let id = try LiveActivityManager.startActivity(arrivalTime: "15 min" , phoneNumber: "123445678" , resturantName: "Al baik", customerAddress: "Al Qudas", remainingDistance: "15 km")
                    
                    UserDefaultManager.saveNewActivity(id: id, arrivalTime: "15 min" , phoneNumber: "123445678" , resturantName: "Al baik", customerAddress: "Al Qudas", remainingDistance: "15 km")
                } catch {
                    print(error.localizedDescription)
                }
                
            }, label: {
                Text("Start The Experiance")
            })
        }
        .padding()
    }
    
    private func deleteAllActitivites(){
        for item in UserDefaultManager.fetchActivities(){
            if let activity = Activity<FlightAttribute>.activities.first(where: {
                $0.contentState.phoneNumber == item.phoneNumber })
            {
                Task {
                    await LiveActivityManager.endActivity(activity.id)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
