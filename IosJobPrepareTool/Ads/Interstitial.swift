//
//  Interstitial.swift
//  IosJobPrepareTool
//
//  Created by mengjiao on 2/4/21.
//

import SwiftUI

import UIKit
// implement add in app :
// refer to :https://medium.com/@michaelbarneyjr/how-to-integrate-admob-ads-in-swiftui-fbfd3d774c50

// problem : cannot find GADInterstitial in scope
//final class Interstitial:NSObject, GADInterstitialDelegate{
//    var interstitial:GADInterstitial = GADInterstitial(adUnitID: interstitialID)
//
//    override init() {
//        super.init()
//        LoadInterstitial()
//    }
//
//    func LoadInterstitial(){
//        let req = GADRequest()
//        self.interstitial.load(req)
//        self.interstitial.delegate = self
//    }
//
//    func showAd(){
//        if self.interstitial.isReady{
//           let root = UIApplication.shared.windows.first?.rootViewController
//           self.interstitial.present(fromRootViewController: root!)
//        }
//       else{
//           print("Not Ready")
//       }
//    }
//
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        self.interstitial = GADInterstitial(adUnitID: interstitialID)
//        LoadInterstitial()
//    }
//}

