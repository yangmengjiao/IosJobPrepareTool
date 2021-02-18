//
//  Question.swift
//  Project8
//
//  Created by mengjiao on 1/29/21.
//  Copyright © 2020 mengjiao yang. All rights reserved.



import Foundation


struct Question: Codable, Identifiable, Hashable {
    let id: Int
    let topic: String
    let question: String
    let answer: String
    let demo: String?
    let showAnswer: Bool?
}

