//
//  SettingsManager.swift
//  HWlesson30
//
//  Created by Карина Дьячина on 31.03.24.
//

import Foundation

class SettingsManager {
    private static var queue = DispatchQueue(label: "userDefaults-queue")
    
    @UserDefault(key: Key.score, defaultValue: 0, queue: queue)
    static var score: Int
    
    @UserDefault(key: Key.level, defaultValue: 0, queue: queue)
    static var level: Int
    
    @UserDefault(key: Key.scoreLabel, defaultValue: "", queue: queue)
    static var scoreLabel: String
    
    @UserDefault(key: Key.levelLabel, defaultValue: "", queue: queue)
    static var levelLabel: String
    
}

fileprivate struct Key {
    static var score = "score"
    static var level = "level"
    static var levelLabel = "levelLabel"
    static var scoreLabel = "scoreLabel"
}

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    var queue: DispatchQueue
    
    var wrappedValue: Value {
        get {
            var value: Value? = nil
            queue.sync {
                value = container.object(forKey: key) as? Value
            }
            return value ?? defaultValue
        }
        set {
            queue.sync {
                container.setValue(newValue, forKey: key)
            }
        }
    }
}
