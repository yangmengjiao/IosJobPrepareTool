////
////  Interstitial.swift
////  IosJobPrepareTool
////
////  Created by mengjiao on 2/4/21.
////
//
import GoogleMobileAds
import SwiftUI

import UIKit
//// implement add in app :
//// refer to :https://medium.com/@michaelbarneyjr/how-to-integrate-admob-ads-in-swiftui-fbfd3d774c50

final class Interstitial:NSObject, GADFullScreenContentDelegate{
    var ad: GADInterstitialAd?

    override init() {
        super.init()
        loadInterstitial()
    }
    
    func loadInterstitial() {
        let id = "ca-app-pub-3707970019102662/1823361134"
        GADInterstitialAd.load(withAdUnitID: id, request: GADRequest()) { ad, error in
            if error != nil { return }
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
        }
    }
    
    func showAd(){
        if let loadedAd = self.ad {
           let root = UIApplication.shared.windows.first?.rootViewController
            loadedAd.present(fromRootViewController: root!)
        }
       else{
           print("Not Ready")
       }
    }
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("present-ads")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("dismiss-ads")
    }


}

