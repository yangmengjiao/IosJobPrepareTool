//
//  SettingView.swift
//  IosJobPrepareTool
//
//  Created by mengjiao on 2/3/21.
//

import SwiftUI
import StoreKit

struct SettingView: View {
    @State var username: String = ""
    @State var notificationsEnabled: Bool = false

    @State private var showingSheet = false
    
    var voiceType = ["Male", "Female"]
    
    @ObservedObject var model = SettingViewModel()

    var body: some View {
     
            Form {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $model.loopPlay) {
                        Text("Loop Play")
                    }
                    Picker(selection: $model.voiceTypeIndex, label: Text("Voice")) {
                        ForEach(0 ..< voiceType.count) {
                            Text(self.voiceType[$0])
                        }
                    }
                }
                
                Section(header: Text("Contact")) {
                    HStack {
                        Image(systemName: "envelope")
                        Text("Send me feedback")
                            .onTapGesture {
                                let email = "foo@bar.com"
                                if let url = URL(string: "mailto:\(email)") {
                                  if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url)
                                  } else {
                                    UIApplication.shared.openURL(url)
                                  }
                                }
                            }
                    }
                    
                }

                
                Section(header: Text("ABOUT"),footer:
                            VStack {
                                Text("We have nothing on you, we collect absolutely nothing.")
                                Button(action: {
                                    self.showingSheet = true
                                }) {
                                    Text("Privacy policy and legal notice")
                                        .foregroundColor(Constant.myOrangeColor)
                                }
                                .sheet(isPresented: $showingSheet, content: {
                                    PrivacyView()
                                        .navigationTitle("Privacy policy and Legal notice")
                                })
                            }
                
                
                ) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                    }
                }
             
            }
         //   .navigationBarTitle("Settings")
        
    }
    
    
    

    func rateApp() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
