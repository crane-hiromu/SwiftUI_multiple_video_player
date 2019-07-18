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
    
//    @State private var presious = 0 {
//        didSet {
//            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//                self.data.append(self.presious)
//            }
//
//        }
//    }
    @State private var data = [0, 1, 2, 3, 4, 5]
    
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

        
        
 
        
        ZStack {
            ForEach(data) { index in
                Video()
                    .frame(width: self.getLine(index), height: self.getLine(index))
                    .background(Color.gray)
                    .animation(.linear)
                    .offset(x: ((index == self.data.first) ? self.currentOffset : 0),
                            y: Length(index*(-10)))
                    .opacity(self.getOpacity(index))
                    .zIndex(self.getZIndex(index))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                print("----onChanged")
                                print("----", value.translation.width)
                                self.currentOffset = value.translation.width
                                 
                            }
                            .onEnded { value in
                                print("----onEnded")
    //                            self.currentOffset = 0
                                let presious = self.data.remove(at: 0)
                                self.data.append(presious+1)
                                //                        if 0 < value.translation.width {
                                //                            self.currentOffset += UIScreen.main.bounds.width
                                //                        } else {
                                //                            self.currentOffset -= UIScreen.main.bounds.width
                                //                        }
                                
                            }
                )
            }
//            .onMove(perform: { index in
//
//            })
        }

            //            .animation(.none)
            //            .animation(.spring())
//
        //            .opacity(self.currentOpacity)
    }
    
    func getLine(_ index: Int) -> CGFloat {
        return UIScreen.main.bounds.width-CGFloat(index*10)
    }
    
    func getOpacity(_ index: Int) -> Double {
        return Double(1)-Double(index)/10
    }
    
    func getZIndex(_ index: Int) -> Double {
        return Double(index) * (-1)
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
