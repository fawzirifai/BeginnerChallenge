//
//  Venue.swift
//  BeginnerChallenge
//
//  Created by Penguin eers on 19/07/2022.
//

struct Venue: Codable {
    let ID: Int
    let Name: [Name]
    let campusId: Int
    let Points: String
    let CenterPoint: String
    let UpdateStatus: Int
    let isBLE: Int
    let isMix: Int
    let isWiFi: Int
    
    var localizedName: String {
        for name in self.Name {
            if name.code == Settings.shared.language.rawValue {
                return name.value
            }
        }
        return self.Name[0].value
    }
    
    struct Name: Codable {
        let code: String
        let value: String
    }
}
