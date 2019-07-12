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

struct ContentView : View {
    
//    @State var video: Video = Video()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<6) { item in
                    Video()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        .onAppear(perform: {
                            print("-----onAppear")
                        })
                        .onDisappear(perform: {
                            print("-----onDisappear")
                        })
                    
                }
            }
        }

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
