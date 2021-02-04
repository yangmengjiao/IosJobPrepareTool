//
//  ModelLayer.swift
//  Project8
//
//  Created by mengjiao on 1/21/21.
//  Copyright © 2021 Paul Hudson. All rights reserved.
//

import Foundation


struct ModelLayer {
    static var questions: [Question] = Bundle.main.decode("questions.json")
    static var sortedAllQuestions: [Question] {
        return questions.sorted {$0.question.first! < $1.question.first!}
    }
    static var topics: [Topic] {
        var arr = [Topic]()
        for (key, value) in dict {
            arr.append(Topic(topic: key, questions: value))
        }
        return arr
    }
    static var dict: [String : [Question]]{
        
        var dict = [String : [Question]]()
        for question in questions {
            dict[question.topic, default: []] += [question]
        }
        return dict
    }
   
}

struct Topic: Hashable,Identifiable {
    let id = UUID()
    var topic: String
    var questions: [Question]
    var imageName: String {
        switch topic {
        case "Agile":
            return "agile"
        case "NetWorking":
            return "networking"
        case "Test Related":
            return "unitTest"
        case "UI Related":
            return "ui"
        case "Design Patten":
            return "designPatter"
        case "ios Basics":
            return "basic"
        case "Swift":
            return "swift"
        case "Frequently asked":
            return "faq"
        case "Multithreading":
            return "memory"
        case "Objective-c":
            return "oc"
        case "What's new":
            return "new"
        default:
            return "icon1"
        }
        
    }
}
