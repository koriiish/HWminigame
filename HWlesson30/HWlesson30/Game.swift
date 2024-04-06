//
//  Game.swift
//  HWlesson30
//
//  Created by Карина Дьячина on 26.03.24.
//

import Foundation

class Game {
    var secretNumber: Int
    var answer: Int
    
    init() {
        secretNumber = 0
        answer = 0
    }
    
    func generateSecretNumber() {
        secretNumber = Int.random(in: 1...10)
    }
    
    func isRight(answer: Int) -> Bool {
        secretNumber == answer
    }
}
