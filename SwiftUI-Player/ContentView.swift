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

// MARK: - View

struct ContentView: View {
    
    // MARK: Enums
    
    enum VectorState {
        case before, after, current
        
        static func type(_ width: CGFloat) -> VectorState {
            switch (width < -70, 70 < width) {
            case (true, _): return .after
            case (_, true): return .before
            case (false, false):return .current
            }
        }
    }
    
    
    // MARK: Properties
    
    private var width: CGFloat = UIScreen.main.bounds.width-100
    private var height: CGFloat = UIScreen.main.bounds.width
    
    private var viewModels: [ViewModel] {
        return data.enumerated().filter { $0.offset < 3 }.map { $0.element }
    }
    
    private var secondItemOffset: CGFloat {
        switch currentOffset {
        case let offset where 0 < offset: return currentOffset - width
        case let offset where offset < 0: return currentOffset + width
        default: return currentOffset
        }
    }
    
    // MARK: State Properties
    
    @State var currentOffset: CGFloat = .zero
    @State var lastItem: ViewModel? = nil {
        didSet {
            // 参照が残ってしまうので、新しいインスタンスとして生成し直す
            guard let item = lastItem else { return }
            let newItem = ViewModel(color: item.color)
            data.append(newItem)
        }
    }
    
    @State private var data: [ViewModel] = [
        ViewModel(color: .red),
        ViewModel(color: .green),
        ViewModel(color: .blue),
        ViewModel(color: .orange),
        ViewModel(color: .yellow)
    ]

    @State var vectorState: VectorState = .current {
        didSet {
            switch vectorState {
            case .before:
                self.currentOffset += (width-currentOffset)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.vectorState = .current
                    self.lastItem = self.data.removeFirst()
                }
                
            case .after:
                self.currentOffset -= (width+currentOffset)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.vectorState = .current
                    self.lastItem = self.data.removeFirst()
                }
                
            case .current:
                self.currentOffset = 0
            }
        }
    }
    

    // MARK: Views
    
    var body: some View {
        ZStack {
            ForEach(viewModels, id:(\.self)) { model in
                if self.data.firstIndex(of: model) == self.data.startIndex {
                    Video()
                        .frame(width: self.width, height: self.height)
                        .background(model.color)
                        .animation(.default)
                        .offset(x: self.currentOffset, y: 0)
                        .gesture(DragGesture()
                            .onChanged { value in
                                self.currentOffset = value.translation.width
                            }.onEnded { value in
                                self.vectorState = VectorState.type(value.translation.width)
                            })
                        
                } else if self.data.firstIndex(of: model) == self.data.startIndex+1 {
                    Video()
                        .frame(width: self.width, height: self.height)
                        .background(model.color)
                        .animation(.default)
                        .offset(x: self.secondItemOffset, y: 0)
                        .zIndex(-1)
                } else {
                    Video()
                        .frame(width: self.width, height: self.height)
                        .hidden()
                }

            }
//            .onMove(perform: { index in
//
//            })
        }
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
        
//        let url = URL(string: "https://media.delishkitchen.tv/recipe/142662346819502579/1.mp4")!
//        let player = AVPlayer(url: url)
////        player.play()
//
//        playerLayer.player = player
//        layer.addSublayer(playerLayer)
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

struct ViewModel: Hashable {
    let color: Color
}
