//
//  Home.swift
//  UI-530
//
//  Created by nyannyan0328 on 2022/04/04.
//

import SwiftUI

struct Home: View {
    @State var currentIndex : Int = 0
    @State var posts : [Post] = []
    @State var currentTab : String = "Silde show"
    @Namespace var animation
    var body: some View {
        VStack{
            
            VStack(alignment: .leading, spacing: 15) {
                
                Button {
                    
                } label: {
                    
                    HStack{
                        
                        Image(systemName: "arrow.left")
                            .font(.title.weight(.bold))
                        
                        Text("My wishes")
                            
                    }
                    .foregroundColor(.black)
                    
                    
                }
                
                Text("My Wishes")
                    .font(.largeTitle.weight(.bold))

                
            }
            .lLeading()
            
            SlideButton()
                .padding()
            
            
            
            SnapCarouselView(index: $currentIndex, items: posts) { post in
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(10)
                }
                
            }
            
            
            HStack(spacing:15){
                
                ForEach(posts.indices,id:\.self){index in
                    
                    Circle()
                        .fill(currentIndex == index ? .brown : .black)
                        .frame(width: 18, height: 18)
                        .scaleEffect(currentIndex == index ? 1.6 : 1)
                        .animation(.easeInOut, value: currentIndex)
                    
                }
            }
            .padding(.top,40)
            
            
            
            
        }
        .padding()
        .maxHWTop()
        .onAppear {
            
            for index in 1...7{
                
                posts.append(Post(postImage: "Movie\(index)"))
                
                
            }
        }
    }
    @ViewBuilder
    func SlideButton()->some View{
        
        HStack(spacing:15){
            
            
            ForEach(["Silde show","List"],id:\.self){title in
                
                
                Button {
                    withAnimation{
                        
                        currentTab = title
                    }
                } label: {
                    Text(title)
                        .font(.title3.weight(.semibold))
                        .foregroundColor(currentTab == title ? .white : .gray)
                        .padding(.vertical,10)
                        .padding(.horizontal,50)
                        .background{
                        
                        
                            if currentTab == title{
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.black)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                                
                        
                            }
                    
                }

                
            }
            
            
        }
        .background(.ultraThinMaterial)
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View{
    
    func getRect()->CGRect{
        
        
        return UIScreen.main.bounds
    }
    
    func lLeading()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    func lTreading()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .trailing)
    }
    func lCenter()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .center)
    }
    
    func maxHW()->some View{
        
        self
            .frame(maxWidth:.infinity,maxHeight: .infinity)
        
    
    }
    
    func maxHWTop()->some View{
        
        self
            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
        
    
    }
}
