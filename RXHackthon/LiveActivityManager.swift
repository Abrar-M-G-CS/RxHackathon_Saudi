//
//  LiveActivity.swift
//  RxHackathon_Saudi
//
//  Created by Abrar Ghandurah on 17/04/1446 AH.
//

import Foundation
import ActivityKit

class LiveActivityManager {

    @discardableResult
    static func startActivity(arrivalTime: String, phoneNumber:String, resturantName:String, customerAddress:String , remainingDistance:String) throws -> String {

            var activity: Activity<FlightAttribute>?
            let initialState = FlightAttribute.ContentState(arrivalTime: arrivalTime, phoneNumber: phoneNumber, resturantName: resturantName, customerAddress: customerAddress, remainingDistance: remainingDistance)
        do {
            activity = try Activity.request(attributes: FlightAttribute(), contentState: initialState, pushType: nil)
            guard let id = activity?.id else { throw LiveActivityErrorType.faildToGetID }
            return id
        } catch {
            throw error
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
