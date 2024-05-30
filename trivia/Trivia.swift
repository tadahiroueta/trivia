//
//  Trivia.swift
//  trivia
//
//  Created by Ueta, Lucas T on 2/27/24.
//

import Foundation

struct Trivia {
    let question: String
    let correct: String
    let incorrect: [String]
    
    init(q: String, correct: String, incorrect: [String]) {
        self.question = q
        self.correct = correct
        self.incorrect = incorrect
    }
}
