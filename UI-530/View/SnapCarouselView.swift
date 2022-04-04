//
//  SnapCarouselView.swift
//  UI-530
//
//  Created by nyannyan0328 on 2022/04/04.
//

import SwiftUI

struct SnapCarouselView<Content : View,T : Identifiable>: View {
    
    var content : (T) -> Content
    var list : [T]
    var spacing : CGFloat
    var trailingSpace : CGFloat
    @Binding var index : Int
    
    
    init(spacing : CGFloat = 15,trailingSpace : CGFloat = 100,index : Binding<Int>,items : [T],@ViewBuilder content : @escaping(T) -> Content) {
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.list = items
        self.content = content
    }
    
    @GestureState var offset : CGFloat = 0
    
    @State var currentIndex : Int = 0
    
    
    
    var body: some View {
        GeometryReader{proxy in
            
            let widht = proxy.size.width - (trailingSpace - spacing)
      
            let adustWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing:spacing){
                
                ForEach(list){item in
                    
                    content(item)
                        .frame(width: proxy.size.width  - trailingSpace)
                    
                }
                
                
            }
            .padding(.horizontal,spacing)
            .offset(x: (CGFloat(currentIndex) * -widht) + (currentIndex != 0 ? adustWidth : 0) + offset)
            .gesture(
            
            
                DragGesture().updating($offset, body: { value, out, _ in
                    out = value.translation.width
                })
                .onEnded({ value in
                    
                    let offsetX = value.translation.width
                    
                    let progress = -offsetX  / widht
                    
                    let roundIndex  = progress.rounded()
                    
                    currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    
                    currentIndex = index
                    
                    
                })
                .onChanged({ value in
                    
                    
                    let offsetX = value.translation.width
                    
                    let progress = -offsetX  / widht
                    
                    let roundIndex  = progress.rounded()
                    
                    index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    
                   
                    
                    
                })
            
            )
            
        }
        .animation(.easeInOut, value: index == 0)
    }
}

struct SnapCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
