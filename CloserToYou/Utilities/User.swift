//
//  User.swift
//  CloserToYou
//
//  Created by Daniel Pinilla on 1/3/25.
//

import Foundation


struct User: Identifiable, Codable{
    var id: UUID?
    var firstName: String
    var password: String
   
    var points: Int
    var mood: Mood
    var partnerID: Int
    var email: String
    var pairingCode: Int
    
}

struct SendUser: Identifiable, Codable{
    var id: UUID?
    var firstName: String
    var password: String
    var points: Int
    var email: String
   
}

struct Mood: Identifiable, Codable{
    let id: UUID?
    var Name: String
    var emoji: String
    var color :String
}
