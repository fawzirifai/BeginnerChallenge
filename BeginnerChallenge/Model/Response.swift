//
//  Response.swift
//  BeginnerChallenge
//
//  Created by Penguin eers on 19/07/2022.
//

struct Response: Codable {
    var GetVenuesResult: [Venue]
}

struct TokenResponse: Codable {
    let Token: String
}
