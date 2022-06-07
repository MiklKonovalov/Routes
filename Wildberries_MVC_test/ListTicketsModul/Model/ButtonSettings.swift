//
//  ButtonSettings.swift
//  Wildberries_MVC_test
//
//  Created by Misha on 06.06.2022.
//

import Foundation

final class ButtonSettings {
    
    private enum SettingsKeys: String {
        case isButtonTapped
    }
    
    static var isButtonTapped: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: SettingsKeys.isButtonTapped.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.isButtonTapped.rawValue
            if let status = newValue {
                defaults.set(status, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
