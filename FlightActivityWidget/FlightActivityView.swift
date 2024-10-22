
//  FlightActivityView.swift
//  RXHackthon
//
//  Created by Abrar Ghandurah on 18/04/1446 AH.
//
import SwiftUI

struct FlightActivityView: View {
    var state: FlightAttribute.ContentState
    @State private var currentPhase: Int = 1 // This represents the current phase (adjust dynamically)

    let totalPhases = 4 // Total number of phases

    var body: some View {
        VStack(alignment: .center) {
            
            // First horizontal stack for the header (level names)
            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(Color(bgColor))
                        .frame(width: 140, height:  20)
                    
                        
                    Text("Level 3: Saudi Coffee")
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 12))
                }.frame(width: 150, height:  16)
                
            }
            .padding(.top,10)
            .padding(.trailing,174)
            
            // Second horizontal stack for the main content (instructions and image)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Head to your gate")
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 18))
                        .bold()

                    Text("Find a seat, relax, and listen for boarding announcements.")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(descriptionColor))
                        .fixedSize(horizontal: false, vertical: true) // Ensures multi-line text wrapping
                }
                .padding(.horizontal, -1)
                .padding(.bottom,-8)

                Spacer()

                Text("☕️")
                    .font(.system(size: 30))
            }
            .padding(.horizontal, 30)
           
            // Custom progress bar with 4 phases
            HStack(spacing: 17) {
                ForEach(0..<totalPhases, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 5)
                        .fill(index <= currentPhase ? Color(bgColor) : Color.gray.opacity(0.3)) // Color based on current phase
                        .frame(width: 67, height: 6)
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom,10)
        }
        .frame(width:370,height: 128)
        .background(Color.clear)
    }
}

#Preview {
    FlightActivityView(state: .init(arrivalTime: "12:00", phoneNumber: "+971500000000", resturantName: "Restaurant Name", customerAddress: "Customer Address", remainingDistance: "100 km"))
}
