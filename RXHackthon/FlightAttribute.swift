//
//  FlightAttribute.swift
//  RxHackathon_Saudi
//
//  Created by Abrar Ghandurah on 17/04/1446 AH.
//

import Foundation
import SwiftUI
import ActivityKit


struct FlightAttribute: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var arrivalTime: String
        var phoneNumber: String
        var resturantName: String
        var customerAddress: String
        var remainingDistance: String
    }
}
