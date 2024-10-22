import Foundation
import ActivityKit

class LiveActivityManager {
    
    // Singleton instance
    static let shared = LiveActivityManager()

    // The activity instance
    private var activity: Activity<FlightAttribute>?

    private init() {} // Private initializer to enforce singleton

    // Starting the live activity
    @discardableResult
    static func startActivity(arrivalTime: String, phoneNumber:String, resturantName:String, customerAddress:String , remainingDistance: String) throws -> String {

        let initialState = FlightAttribute.ContentState(arrivalTime: arrivalTime, phoneNumber: phoneNumber, resturantName: resturantName, customerAddress: customerAddress, remainingDistance: remainingDistance)
        
        do {
            // Use the shared instance to set the activity
            LiveActivityManager.shared.activity = try Activity.request(attributes: FlightAttribute(), contentState: initialState, pushType: nil)
            
            guard let id = LiveActivityManager.shared.activity?.id else { throw LiveActivityErrorType.faildToGetID }

            // Start periodic updates
            startUpdatingActivity(id: id)

            return id
        } catch {
            throw error
        }
    }

    // New method to update the activity every 10 seconds
    static func startUpdatingActivity(id: String) {
        let updates = [
            FlightAttribute.ContentState(arrivalTime: "12:05", phoneNumber: "+971500000000", resturantName: "Restaurant", customerAddress: "Customer Address", remainingDistance: "50 km"),
            FlightAttribute.ContentState(arrivalTime: "12:10", phoneNumber: "+971500000000", resturantName: "Restaurant", customerAddress: "Customer Address", remainingDistance: "10 km"),
            FlightAttribute.ContentState(arrivalTime: "12:15", phoneNumber: "+971500000000", resturantName: "Restaurant", customerAddress: "Customer Address", remainingDistance: "Arrived!")
        ]
        
        var phaseIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            if phaseIndex < updates.count {
                Task {
                    // Update the live activity with the new state
                    await updateActivity(id: id, arrivalTime: updates[phaseIndex].arrivalTime, phoneNumber: updates[phaseIndex].phoneNumber, resturantName: updates[phaseIndex].resturantName, customerAddress: updates[phaseIndex].customerAddress, remainingDistance: updates[phaseIndex].remainingDistance)
                }
                phaseIndex += 1
            } else {
                timer.invalidate() // Stop timer when all phases are done
            }
        }
    }

    static func listAllActivities() -> [[String:String]] {
        let sortedActivity = Activity<FlightAttribute>.activities.sorted { $0.id > $1.id }
        return sortedActivity.map {
            [
                "id": $0.id,
                "arrivalTime": $0.contentState.arrivalTime,
                "phoneNumber": $0.contentState.phoneNumber,
                "resturantName": $0.contentState.resturantName,
                "customerAddress": $0.contentState.customerAddress,
                "remainingDistance": $0.contentState.remainingDistance
            ]
        }
    }

    static func endAllActivites() async {
        for activity in Activity<FlightAttribute>.activities {
            await activity.end(dismissalPolicy: .immediate)
        }
    }

    static func endActivity(_ id: String) async {
        await Activity<FlightAttribute>.activities.first(where: { $0.id == id })?.end(dismissalPolicy: .immediate)
    }

    static func updateActivity(id: String, arrivalTime: String, phoneNumber: String, resturantName: String, customerAddress: String , remainingDistance: String) async {
        let updatedContentState = FlightAttribute.ContentState(arrivalTime: arrivalTime, phoneNumber: phoneNumber, resturantName: resturantName, customerAddress: customerAddress, remainingDistance: remainingDistance)
        let activity = Activity<FlightAttribute>.activities.first(where: { $0.id == id })
        await activity?.update(using: updatedContentState)
    }
}

enum LiveActivityErrorType: Error {
    case faildToGetID
}
