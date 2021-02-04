//
//  EmbeddedExampleView.swift
//  IosJobPrepareTool
//
//  Created by mengjiao on 1/29/21.
//  Copyright © 2020 mengjiao yang. All rights reserved.



import SwiftUI
import SwiftUIPager



struct CardModeView: View {
    var question: [Question]
    @EnvironmentObject var page1: Page
    @State var isPlaying: Bool = false
    
    @State private var loopPlay = UserDefaults.standard.bool(forKey: "loopPlay")
    @State private var voiceTypeIndex = UserDefaults.standard.integer(forKey: "voiceType")
    @State var currendIdx: Int = 0 {
        didSet{
            playSound("\(question[currendIdx].question)\(question[currendIdx].answer)")
            }
    }
    
    var data = Array(0..<10)

    @State var alignment: ExamplePositionAlignment = .start

    var body: some View {

            GeometryReader { proxy in
                VStack {
                    Pager(page: self.page1,
                          data: self.question,
                          id: \.self) { question in
                            self.pageView(question)
                    }
                    .onPageChanged({ (newIndex) in
                            stop()
                        if isPlaying {
                            playSound("\(question[newIndex].question)\(question[newIndex].answer)")
                        }
                        })
                    .rotation3D()
                    .itemSpacing(10)
                    .itemAspectRatio(0.8, alignment: .end)
                    .padding(8)
                    .preferredItemSize(CGSize(width: proxy.size.height * 0.8 * 0.618, height: proxy.size.height * 0.8))
                    .background(Color(UIColor(red: 0.99, green: 0.80, blue: 0.60, alpha: 1.00)))
                    
                   
                }
                
            }.navigationBarTitle("Card Mode", displayMode: .inline)
         
            .navigationBarItems(
                trailing:
                    Button(action: {
                       
                       
                        // todo: play sounds tts
                        if isPlaying {
                            self.stop()
                        } else {
                            currendIdx = page1.index
                            playSound("\(question[currendIdx].question)\(question[currendIdx].answer)")
                        }
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill").imageScale(.large)
                    }
            )
            .onDisappear(perform: stop)

    }
    func stop() {
        SpeechService.shared.stop()
    }
    
    func getVoiceType() -> VoiceType {
        voiceTypeIndex = UserDefaults.standard.integer(forKey: "voiceTypeIndex")
        switch voiceTypeIndex {
        case 0:
            return .waveNetMale
        case 1:
            return .waveNetFemale
        default:
            return .waveNetFemale
        }
    }
    
    func playSound(_ text: String) {
        SpeechService.shared.speak(text: text, voiceType: self.getVoiceType()) {
            guard currendIdx + 1 < question.count else {
                return
            }
            
            if !loopPlay {
                currendIdx += 1
                
                withAnimation {
                    self.page1.update(.next)
                }
            }
        }
    }

    func pageView(_ question: Question) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor(red: 0.97, green: 0.95, blue: 0.95, alpha: 1.00)))
            
            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 16){
                Text("\(question.question)")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all)
                    
                    .frame(width: geo.size.width, height: geo.size.height * 0.382, alignment: .center)
                        .background(Color(UIColor(red: 0.97, green: 0.56, blue: 0.00, alpha: 1.00)))
                    Text("Answer:\n \(question.answer)")
                        .minimumScaleFactor(0.2)
                        .padding()
                }
               
            }
            
        }
        .cornerRadius(5)
        .shadow(radius: 5)
    }

}

enum ExamplePositionAlignment: String, CaseIterable {
    case start
    case justified
    case end
}

extension PositionAlignment {
    init(alignment: ExamplePositionAlignment) {
        switch alignment {
            case .start:
                self = .start(10)
            case .end:
                self = .end(10)
            case .justified:
                self = .justified(10)
        }
    }
}
