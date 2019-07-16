//
//  ContentView.swift
//  SwiftUI-Player
//
//  Created by admin on 2019/07/07.
//  Copyright © 2019 h.crane. All rights reserved.
//

import SwiftUI
import AVFoundation
import AVKit
import Combine

struct ContentView: View {
    
    @State var currentOffset: CGFloat = .zero
    @State var currentOpacity: Double = 1.0
    
    private var data = [0, 1, 2, 3, 4, 5]
    @State private var rows: [Int] = []
    
    var body: some View {
//        GeometryReader { parentGeometry in
//            VStack {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        GeometryReader { childGeometry -> Text in
//                            let offset = childGeometry.frame(in: .local)
//                            let offsetG = childGeometry.frame(in: .global)
//                            if self.currentOffset != offset.minY {
//                                self.currentOffset = offset.minY
//                            }
//                            print("------", offset, offsetG)
//                            return Text("")
//                        }
//                        ForEach(0..<6) { index in
//                            Video()
//                                .frame(width: UIScreen.main.bounds.width,
//                                       height: UIScreen.main.bounds.width)
//                        }
//                    }
//                    //                .fixedSize(horizontal: false, vertical: true)
//                    //                .frame(height: parentGeometry.size.height)
//                }
//
//
//                Button(action: {
//                    self.changeOffset = !self.isSelected ? 0 : 200
//                    self.isSelected.toggle()
//
////                        .animation(.spring())
////                        .position(x: self.changeOffset)
//                }, label: {
//                    Text("set")
//                }).animation(.basic())
//            }
//        }
        
        
//        .frame(width: UIScreen.main.bounds.width,
//                height: UIScreen.main.bounds.width)

        
        
        
//        GeometryReader { parentGeometry in
//            List(self.data) { item in
//                VStack {
//                    GeometryReader { childGeometry -> Text in
//                        let offset = childGeometry.frame(in: .global)
//
//                        if item.id == 0, item.id != self.currentRow {
//                            self.currentRow = item.id
//                            self.currentOffset = offset.minX
//                            print("------", item.id, offset)
//                        }
//
//                        return Text("")
//                    }
//                    Video()
////                        .rotationEffect(.radians(.pi/2))
//                        .frame(width: UIScreen.main.bounds.width-50,
//                               height: UIScreen.main.bounds.width-50)
//                        .onAppear(perform: {
//                            print("-----onAppear", item.id)
////                            self.rows.append(item.id)
//                            self.currentRow = item.id
//                        })
//                        .onDisappear(perform: {
//                            print("-----onDisappear", item.id)
////                            self.rows = self.rows.filter { $0 != item.id }
//                        })
//                        .animation(.spring())
//                        .offset(y: self.currentOffset)
//                }
////                .fixedSize(horizontal: true, vertical: true)
//            }
////            .rotationEffect(.radians(-.pi/2))
//        }
//        .frame(width: UIScreen.main.bounds.width,
//               height: UIScreen.main.bounds.width)
        
        
//        GeometryReader { parentGeometry in
            HStack {
//                GeometryReader { childGeometry -> Text in
//                    let offset = childGeometry.frame(in: .local)
//                    let offsetG = childGeometry.frame(in: .global)
//                    //                        if self.currentOffset != offset.minY {
//                    //                            self.currentOffset = offset.minY
//                    //                        }
//                    print("------", offset, offsetG)
//                    return Text("")
//                }
                ForEach(0..<6) { index in
                    Video()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.width)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
//                        print("----onChanged",
//                              value.translation.width,
//                              value.translation.height,
//                              value.location,
//                              value.startLocation,
//                              value.predictedEndLocation,
//                              value.predictedEndTranslation)
//
//
                        
//                        self.currentOpacity = 0
                    }
                    .onEnded { value in
                        print("----onEnded")
                        
                        
                        
                        if 0 < value.translation.width {
                            self.currentOffset += UIScreen.main.bounds.width
                        } else {
                            self.currentOffset -= UIScreen.main.bounds.width
                        }
                        
//                        self.currentOpacity = 1
                    }
            )
//            .animation(.none)
            .offset(x: self.currentOffset)
//            .opacity(self.currentOpacity)
//        }
    }
}

struct Video: UIViewRepresentable {
    
    let player = PlayerView(frame: .zero)
    
    func makeUIView(context: Context) -> PlayerView {
        player
    }
    
    func updateUIView(_ uiView: PlayerView, context: UIViewRepresentableContext<Video>) {
        
    }
}

class PlayerView: UIView {
    
    private let playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let url = URL(string: "https://media.delishkitchen.tv/recipe/142662346819502579/1.mp4")!
        let player = AVPlayer(url: url)
//        player.play()
        
        playerLayer.player = player
        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    func play() {
        playerLayer.player?.play()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
