//
//  ContentView.swift
//  IosJobPrepareTool
//
//  Created by mengjiao on 1/29/21.
//  Copyright © 2020 mengjiao yang. All rights reserved.


import SwiftUI
import QGrid

struct MainView: View {
    @State private var selectedTab = Tabs.tab1
    
   
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectedTab) {
                
                QGrid(ModelLayer.topics,
                      columns: 2,
                      vSpacing: 12,
                      hSpacing: 12
                ) {
                    GridCell(topic: $0)
                }
                    .tabItem {
                        Image(systemName: Tabs.tab1.imageName)
                        Text(Tabs.tab1.title)
                }.tag(Tabs.tab1)
                
                QuestionListView(question: ModelLayer.sortedAllQuestions, showSearch: true)
                    .tabItem {
                        Image(systemName: Tabs.tab2.imageName)
                        Text(Tabs.tab2.title)
                }.tag(Tabs.tab2)
                
            
                SettingView()
                    .tabItem {
                        Image(systemName: Tabs.tab4.imageName)
                        Text(Tabs.tab4.title)
                }.tag(Tabs.tab4)
            }
            .accentColor(Constant.myOrangeColor)
            .navigationBarTitle(selectedTab.navigationTitle, displayMode: selectedTab.displayLargeMode ? .large : .inline)
            .navigationBarColor(backgroundColor: Constant.myOrangeUIColor, titleColor: selectedTab.navigationBarStyle ? .white : .black)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Constant.navigationTintColor)
    }

}

struct GridCell: View {
    var topic: Topic
    
    var body: some View {
        let d = QuestionListView(question: topic.questions, showSearch: false)
        
        NavigationLink(destination: d) {
            VStack {
                ZStack(alignment: .bottom) {
                   
                    Image(topic.imageName)
                        .resizable()
                        .scaleEffect()
                        .padding([.horizontal, .top], 7)
                        .frame(width: 150, height: 140, alignment: .center)
                        
                    LinearGradient(gradient: Gradient(colors: [.gray]), startPoint: .top, endPoint: .bottom)
                        .opacity(0.2)
                   
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text(topic.topic)
                    .foregroundColor(Constant.myOrangeColor)
                    .bold()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.colorScheme, .light)
    }
}


enum Tabs: Int {
    case tab1
    case tab2
//    case tab3
    case tab4
    
    var title: String {
        switch self {
        case .tab1: return "Categories"
        case .tab2: return "Search"
    //    case .tab3: return "Lists"
        case .tab4: return "Settings"
        }
    }
    
    var navigationTitle: String {
        switch self {
        case .tab1: return "Topics's Categories"
        case .tab2: return "Search"
    //    case .tab3: return "My Lists"
        case .tab4: return "Settings"
        }
    }

    var imageName: String {
        switch self {
        case .tab1: return "rectangle.grid.2x2" // Example using SF Symbol
        case .tab2: return "magnifyingglass"
     //   case .tab3: return "list.star"
        case .tab4: return "gearshape"
        }
    }
    
    var displayLargeMode: Bool {
        switch self {
        case .tab1: return false // Example using SF Symbol
        case .tab2: return false
     //   case .tab3: return "list.star"
        case .tab4: return true
        }
    }
    
    var navigationBarStyle: Bool {
        switch self {
        case .tab1: return true // Example using SF Symbol
        case .tab2: return false
     //   case .tab3: return "list.star"
        case .tab4: return false
        }
    }
}

struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}
