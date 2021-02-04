//
//  QuestionListModelView.swift
//  IosJobPrepareTool
//
//  Created by mengjiao on 2/2/21.
//

import Foundation


class QuestionListModelView: ObservableObject {
    @Published var showSearch = true
    
    func hideSearchFeature() {
        self.showSearch = false
    }
    
    func showSearchFeature() {
        self.showSearch = true
    }
}
