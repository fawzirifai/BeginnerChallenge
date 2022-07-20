//
//  Settings.swift
//  BeginnerChallenge
//
//  Created by Penguin eers on 19/07/2022.
//

import Foundation

struct Settings {
    static var shared = Settings()
    var language = Language(rawValue: UserDefaults.standard.string(forKey: "Language") ?? "en")! {
        didSet {
            UserDefaults.standard.setValue(language.rawValue, forKey: "Language")
        }
    }
    enum Language: String {
        case en, ar
    }
}
