import WidgetKit
import SwiftUI

struct FlightActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightAttribute.self) { context in
            
            VStack(alignment: .leading) {
                
                // Using FlightActivityView component
                FlightActivityView(
                    state: FlightAttribute.ContentState(arrivalTime: "12:00",
                                                        phoneNumber: "+971500000000",
                                                        resturantName: context.state.resturantName,
                                                        customerAddress: context.state.customerAddress,
                                                        remainingDistance: context.state.remainingDistance)
                )
                .padding(.horizontal, 30)
                
            }
            .frame(height: 160)
            .activityBackgroundTint(Color.black.opacity(0.7)) // Change the background opacity of the live view
            
        } dynamicIsland: { context in
            
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    VStack {
                        HStack {
                            Image("falcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                            Text("~\(context.state.arrivalTime)")
                                .font(.system(size: 14))
                                .bold()
                        }
                        .padding(.horizontal, 10)
                        
                        VStack {
                            HStack {
                                Image("CoffeePot")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 44, height: 44)
                                
                                VStack(spacing: 0) {
                                    HStack {
                                        Text("Your food is on delivery")
                                            .font(.system(size: 20))
                                            .bold()
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Button(action: {}, label: {
                                            HStack {
                                                Image(systemName: "phone.fill")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 14, height: 14)
                                                
                                                Text("Call")
                                                    .font(.system(size: 10))
                                                    .foregroundStyle(.white)
                                            }
                                        })
                                        .buttonBorderShape(.capsule)
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("From")
                                .font(.system(size: 8))
                            Text(context.state.resturantName)
                                .font(.system(size: 14))
                                .bold()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("To")
                                .font(.system(size: 8))
                            Text(context.state.customerAddress)
                                .font(.system(size: 14))
                                .bold()
                        }
                    }
                    .frame(height: 20)
                    .padding(.horizontal, 10)
                }
            }
            compactLeading: {
                Image("falcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .font(.system(size: 14))
                    .bold()
            } compactTrailing: {
                Text("En route")
            } minimal: {
                Image("falcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .font(.system(size: 14))
                    .bold()
            }
        }
    }
}
