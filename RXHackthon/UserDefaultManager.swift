//
//  UserDefaultManager.swift
//  RxHackathon_Saudi
//
//  Created by Abrar Ghandurah on 17/04/1446 AH.
//

import Foundation


struct UserDefaultManager {
    static func saveNewActivity(id: String, arrivalTime: String, phoneNumber: String, resturantName: String, customerAddress: String , remainingDistance: String){
        
        let activity = [
            "id": id,
            "arrivalTime": arrivalTime,
            "phoneNumber": phoneNumber,
            "resturantName": resturantName,
            "customerAddress": customerAddress,
            remainingDistance: remainingDistance
        ]
        
        if var activities: [[String:Any]] =
            UserDefaults.standard.array(forKey: "live_activities") as? [[String:String]] {
            
            activities.append(activity)
            UserDefaults.standard.set(activities, forKey: "live_activities")
            
        }else {
            UserDefaults.standard.set([activity], forKey: "live_activities")
        }
    }
    
    static func fetchActivities() -> [FlightAttribute.ContentState] {
        guard let activities: [[String: String]] = UserDefaults.standard.object(forKey: "live_activities") as? [[String: String]] else { return []}
        
        return activities.compactMap({
            FlightAttribute.ContentState(arrivalTime: $0["arrivalTime"] ?? "", phoneNumber: $0["phoneNumber"] ?? "", resturantName: $0["resturantName"] ?? "", customerAddress: $0["customerAddress"] ?? "", remainingDistance: $0["remainingDistance"] ?? "")
        })
    }
}
