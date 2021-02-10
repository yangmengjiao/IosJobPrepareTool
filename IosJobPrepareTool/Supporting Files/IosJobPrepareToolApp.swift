//
//  IosJobPrepareToolApp.swift
//  IosJobPrepareTool
//
//  Created by mengjiao on 1/28/21.
//

import SwiftUI
import GoogleMobileAds

@main
struct IosJobPrepareToolApp: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
