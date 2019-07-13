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

struct ContentView : View {
    
    @State var currentOffset: CGFloat = .zero
    
    var body: some View {
        GeometryReader { parentGeometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    GeometryReader { childGeometry -> Text in
                        let offset = childGeometry.frame(in: .global).minX
                        if self.currentOffset != offset {
                            self.currentOffset = offset
                        }
                        print("------", offset, parentGeometry.size, childGeometry.size)
                        return Text("")
                    }
                    ForEach(0..<6) { item in
                        HStack {
                            Text("Box")
                                .frame(width: 300, height: 300)
                                .foregroundColor(.red)
                            Divider()
                        }
                    }
                }
                .frame(height: parentGeometry.size.height)
            }
        }
        
//        Video()
//            .frame(width: UIScreen.main.bounds.width,
//                   height: UIScreen.main.bounds.width)
        
        
//        .frame(width: UIScreen.main.bounds.width,
//                height: UIScreen.main.bounds.width)
        
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//                ForEach(0..<6) { item in
//                    Video()
//                        .frame(width: UIScreen.main.bounds.width,
//                               height: UIScreen.main.bounds.width)
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    self.currentOffset = value.translation
//                                    print("------onChanged", value.translation, item.id)
//                                }
//                                .onEnded { value in
//                                    //                                    self.currentOffset = .zero
//                                    print("------onEnded", value.translation, item.id)
//                                }
//                            )
//                }
//            }
//        }


//        List(0..<6) { item in
//            Video()
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
//                .rotationEffect(.radians(.pi/2))
//                .onAppear(perform: {
//                    print("-----onAppear", item.id)
//                })
//                .onDisappear(perform: {
//                    print("-----onDisappear", item.id)
//                })
//        }
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
//        .rotationEffect(.radians(-.pi/2))
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
