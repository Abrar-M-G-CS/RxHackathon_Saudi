import SwiftUI

struct FlightActivityView: View {
    var state: FlightAttribute.ContentState
    @State private var currentPhase: Int = 0 // Track the current phase
    
    let totalPhases = 4 // Total number of phases
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect() // 10-second interval for phase update

    var body: some View {
        VStack(alignment: .center) {
            // First horizontal stack for the header (level names)
            HStack{
                ZStack(alignment: .trailing){
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(Color(bgColor))
                        
                    Text("Level \(currentPhase + 1): \(phaseImageName())") // Dynamically update level name based on phase
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 12)).fontWeight(.medium)
                        .padding(.trailing, 40)
                }.frame(width: 140, height: 16)
            }
            .padding(.top, 10)
            .padding(.trailing, 174)
            
            // Second horizontal stack for the main content (instructions and image)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(phaseText()) // Change text based on phase
                        .foregroundStyle(Color(.white))
                        .font(.system(size: 18))
                        .bold()

                    Text(phaseDescription()) // Update description dynamically
                        .font(.system(size: 14))
                        .foregroundStyle(Color(descriptionColor))
                        .fixedSize(horizontal: false, vertical: true) // Ensure multi-line text wrapping
                }
                .padding(.horizontal, -1)
                .padding(.bottom, -8)

                Spacer()

                Image(phaseImageName()) // Dynamically update image based on phase
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
            .padding(.top, 10)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .frame(width: 370, height: 128)
        .background(Color.gray.opacity(0.2)) //frame background
        .onReceive(timer) { _ in
            // Update phase every 10 seconds, cycling back to the first phase
            currentPhase = (currentPhase + 1) % totalPhases
        }
    }
    
    // Function to return the appropriate text based on the current phase
    func phaseText() -> String {
        switch currentPhase {
        case 0:
            return "Drop your luggage"
        case 1:
            return "Scan your bags"
        case 2:
            return "Head to your gate"
        case 3:
            return "Time to board!"
        default:
            return "Loading..."
        }
    }
    
    // Function to return the appropriate description based on the current phase
    func phaseDescription() -> String {
        switch currentPhase {
        case 0:
            return "Go to check-in Area 5"
        case 1:
            return "Show you boarding pass and place items in the X-ray machine"
        case 2:
            return "Find a seat, relax, and listen for boarding announcements"
        case 3:
            return "Line up when your group is called and show your boarding pass to the agent"
        default:
            return "Loading details..."
        }
    }
    
    // Function to return the appropriate image based on the current phase
    func phaseImageName() -> String {
        switch currentPhase {
        case 0:
            return "Camel" // Example image for phase 0
        case 1:
            return "Palm Tree" // Example image for phase 1
        case 2:
            return "Coffe Pot" // Example image for phase 2
        case 3:
            return "Falcon" // Example image for phase 3
        default:
            return "palm" // Fallback image
        }
    }
}

#Preview {
    FlightActivityView(state: .init(arrivalTime: "12:00", phoneNumber: "+971500000000", resturantName: "Restaurant Name", customerAddress: "Customer Address", remainingDistance: "100 km"))
}
