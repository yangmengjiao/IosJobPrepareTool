//
//  SettingViewModel.swift
//  IosJobPrepareTool
//
//  Created by mengjiao on 2/3/21.
//
import Foundation

class SettingViewModel: ObservableObject {
  
    @Published var loopPlay: Bool {
        didSet {
            UserDefaults.standard.set(loopPlay, forKey: "loopPlay")
        }
    }
    
    @Published var voiceTypeIndex: Int {
        didSet {
            UserDefaults.standard.set(voiceTypeIndex, forKey: "voiceTypeIndex")
        }
    }
    
    init() {
        self.loopPlay = UserDefaults.standard.object(forKey: "loopPlay") as? Bool ?? false
        self.voiceTypeIndex = UserDefaults.standard.integer(forKey: "voiceTypeIndex")
    }
}
