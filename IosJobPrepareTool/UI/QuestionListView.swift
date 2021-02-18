//
//  SpeechService.swift
//  IosJobPrepareTool
//
//  Created by mengjiao on 1/29/21.
//  Copyright © 2020 mengjiao yang. All rights reserved.



import SwiftUI
import AVFoundation
import SwiftUIPager

struct QuestionListView: View {
    var question: [Question]
    var showSearch: Bool
    public var  navtitle: String = "test"
    @State var showingAnswer = false
    @State var enableHideFeature = true
    @State var arr = Array(repeating: false, count: 100)
    
    @ObservedObject var model = QuestionListModelView()
    
    // search text for search bar
    @State private var searchText: String = ""
    
    var emptyQuestion = [ Question(id: -111, topic: "", question: "no questions", answer: "", demo: nil, showAnswer: false)]
    
    
    var body: some View {
        if #available(iOS 14.0, *) {

            ZStack {
                Rectangle()
                    .fill(Constant.myOrangeColor)
              
                VStack {
                    // search bar view
                    if showSearch {
                        SearchBar(text: $searchText)
                    }
                
                    if question.filter({ searchText.isEmpty ? true : $0.question.lowercased().contains(searchText.lowercased())}).count > 0 {
                        List(question.filter({ searchText.isEmpty ? true : $0.question.lowercased().contains(searchText.lowercased())}), id: \.self ){ q in
                            let index = question.firstIndex(of: q)!
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(q.question)
                                        .foregroundColor(Constant.myOrangeColor)
                                        .bold()
                                    Spacer()
                                    
                                    Button(action: {
                                   // delete this button
                                        
                                    }) {
                                        Image(systemName: arr[index] ? "chevron.down" : "chevron.right")
                                            .foregroundColor(.gray)
                                        //.renderingMode(.original)
                                    }.padding(5)
                                }.onTapGesture {
                                    withAnimation() {
                                        arr[index].toggle()
                                    }
                                }
                                
                                if arr[index] {
                                    let page = Page.withIndex(index)
                                   NavigationLink(
                                    destination: CardModeView(question: self.question)
                                        .environmentObject(page)
                                   ) {
                                    Text(String(q.answer))
                                        .foregroundColor(.black)
                                        .padding(5)
                                        .transition(.opacity)
        //                                .environmentObject(page)
                                   }
                                }
                            }
                            .listRowBackground(Color(Constant.mylighterOrangeUIColor))
                            
                        }
                        
        //                .environmentObject(page)
                        .buttonStyle(PlainButtonStyle())
                        .navigationBarTitle(navtitle)
                        .navigationBarItems(
                            trailing:
                                Button(action: {
                                    showingAnswer.toggle()
                                    if showingAnswer {
                                        arr = Array(repeating: true, count: 100)
                                    } else {
                                        arr = Array(repeating: false, count: 100)
                                    }
                                }) {
                                    Image(systemName: showingAnswer ? "eye.circle" : "eye.slash").imageScale(.large)
                                }
                                .frame(width: 100, height: 100, alignment: .trailing)
                        )
                    } else {
                        Text("no questions")
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                    }
                    
                }
                
                Banner()

                                
            }
                
  
        } else {
            List(question, id: \.self ){ q in
                VStack {
                    

                    Text(q.question)
                    
                    Text(String(q.answer))
                        .foregroundColor(.gray)
                    
                    
                }
                

                

                
            }
            .navigationBarTitle(navtitle)
            
            Banner()


        }
        


    }
}



//tts api api key
//AIzaSyDWVJB_rqrit_09DclkYvFX97qu7EdRntc
