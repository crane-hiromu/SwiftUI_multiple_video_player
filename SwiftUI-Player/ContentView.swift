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
    var body: some View {
        ScrollView(showsHorizontalIndicator: false) {
            HStack {
                ForEach(0..<6) { _ in
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
        .onHover(perform: { bool in
            print("-----onHover")
        })
        
        
    }
}

struct Video: UIViewRepresentable {
    
    func makeUIView(context: Context) -> PlayerView {
        PlayerView(frame: .zero)
    }
    
    func updateUIView(_ uiView: PlayerView, context: UIViewRepresentableContext<Video>) {
        
    }
    
//    func url(_ urlString: String) -> Video {
//        guard let url = URL(string: urlString) else { return self }
//        
//        let player = AVPlayer(url: url)
//        player.play()
//        
//        playerLayer.player = player
//        layer.addSublayer(playerLayer)
//        return self
//    }
}

class PlayerView: UIView {
    
    private let playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let url = URL(string: "https://media.delishkitchen.tv/recipe/142662346819502579/1.mp4")!
        let player = AVPlayer(url: url)
        player.play()
        
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
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
