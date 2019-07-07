//
//  ContentView.swift
//  SwiftUI-Demo-APP
//
//  Created by admin on 2019/06/05.
//  Copyright © 2019 admin. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView : View {
    private let subContent = SubContentView()
    
    @State var txt = Text("Hello World 1")
    @State var isShown = false
    
    @State var modal: Modal?
    @State var popover: Popover?
    @State var actionSheet: ActionSheet?
    
    var body: some View {
        
//        // move
//        NavigationView {
//            NavigationButton(destination: subContent) {
//                Text("Show Next")
//            }
//        }
        
        
        
         // move
//        PresentationButton(Text("Present"), destination: subContent)
        
        // modal
//        Button(action: {
//            self.modal = Modal(Text("Modal"), onDismiss: {})
//        }) {
//            Text("Show Modal")
//        }.presentation(modal)
        
        
        // popover
//        Button(action: {
//            self.popover = Popover(content: Text("Popover"), dismissHandler: {})
//        }) {
//            Text("Show Popover")
//        }.presentation(popover)
        
        // actionSheet
//        Button(action: {
//            self.actionSheet = ActionSheet(title: Text("Title"),
//                                           message: Text("Message"),
//                                           buttons: [.default(Text("Default")),
//                                                     .destructive(Text("Destructive")),
//                                                     .cancel()])
//        }) {
//            Text("Show ActionSheet")
//        }.presentation(actionSheet)
        

        
        // alert
        Button(action: {
            self.isShown = true
        }) {
            Text("Show Alert")
        }.presentation($isShown, alert: {
            Alert(title: Text("Alert"))
        })

//        }.padding(30)
//            .onAppear() {
//                print("-------onAppear")
//            }
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

struct SubContentView: View {
    
    var body: some View {
        Text("SubContentView").bold()
    }
}

struct BottomSheetView: View {
    var body: some View {
        Text("Hoge")
            .onAppear(perform: {
                
            })
            .onDisappear(perform: {
                
            })
    }
}

class Hoge {
    
    
}
