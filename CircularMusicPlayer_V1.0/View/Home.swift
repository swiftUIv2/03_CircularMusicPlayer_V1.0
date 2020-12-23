//
//  Home.swift
//  CircularMusicPlayer_V1.0
//
//  Created by emm on 21/12/2020.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    
    // for smaller size phones
    @State var width : CGFloat = UIScreen.main.bounds.height < 750 ? 130 : 230
    @State var timer = Timer.publish(every: 0.5, on: .current, in: .default).autoconnect()
    
    var body: some View {
        VStack {

            //topView...
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                
            }
            .padding()
            
            VStack {
                Spacer(minLength: 0)
                
                ZStack {
                    // album image ...
                    Image(uiImage: homeData.album.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: width)
                        .clipShape(Circle())
                    ZStack {
                        // Slider
                        Circle()
                            .trim(from: 0, to: 0.8)
                            .stroke(Color.primary.opacity(0.06), lineWidth: 4)
                            .frame(width: width + 45, height: width + 45)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(homeData.angle) / 360)
                            .stroke(Color("orange"), lineWidth: 4)
                            .frame(width: width + 45, height: width + 45)
                        // slider Circle...
                        Circle()
                            .fill(Color("orange"))
                            .frame(width: 25, height: 25)
                            // Moving View...
                            .offset(x:(width + 45) / 2)
                            .rotationEffect(.init(degrees: homeData.angle))
                        /// gesture...
                            .gesture(DragGesture().onChanged(homeData.onChanged(value:)))
                        
                    } //zstack
                    
                    //Rotating View for bottom facing...
                    // mid 90 deg + 0.1*360 = 36
                    // total 126
                    .rotationEffect(.init(degrees: 126))
                    
                    //Time Texts...
                    Text(homeData.getCurrentTime(value: homeData.player.currentTime))
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .offset(x: UIScreen.main.bounds.height < 750 ? -65 : -85 , y: (width + 60) / 2)
                    
                    Text(homeData.getCurrentTime(value: homeData.player.duration))
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .offset(x: UIScreen.main.bounds.height < 750 ? 65 : 85 , y: (width + 60) / 2)
                    
                } //zstack
                
                
                Text(homeData.album.title)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                    .padding(.top, 25)
                    .padding(.horizontal)
                    .lineLimit(1)
                
                Text(homeData.album.artist)
                    .foregroundColor(.secondary)
                    .padding(.top, 5)
                
                Text(homeData.album.type)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.07))
                    .cornerRadius(5)
                    .padding(.top)
                
                HStack(spacing: 55) {
                    Button(action: {}) {
                        Image(systemName: "backward.fill")
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: homeData.play) {
                        Image(systemName: homeData.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding(20)
                            .background(Color("orange"))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                }// hstack spacing 55
                .padding(.top, 25)
                
                // Volume Control....
                HStack(spacing: 15){
                  Image(systemName: "minus")
                    .foregroundColor(.primary)
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        Capsule()
                            .fill(Color.primary.opacity(0.06))
                            .frame(height: 4)
                        Capsule()
                            .fill(Color("orange"))
                            .frame(width: homeData.volume, height: 4)
                        
                        // slider....
                        Circle()
                            .fill(Color("orange"))
                            .frame(width: 20, height: 20)
                        // gesture ....
                            .offset(x: homeData.volume)
                            .gesture(DragGesture().onChanged(homeData.updateVolume(value:)))
                    }
                    
                    // default frame...
                    .frame(width: UIScreen.main.bounds.width - 160)
                    
                    Image(systemName: "plus")
                      .foregroundColor(.primary)
                }
                .padding(.top, 25)
                
                Spacer(minLength: 0)
            }// vstack 2
            .frame(maxWidth: .infinity)
            .background(Color("bg"))
            .cornerRadius(35)
            
            HStack(spacing: 0) {
                ForEach(buttons, id: \.self) { name in
                    Button(action: {}) {
                       Image(systemName: name)
                        .font(.title2)
                        .foregroundColor(.primary)
                    }
                    if name != buttons.last{Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal, 35)
            .padding(.top, 25)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom != 0 ? 5 : 15)
            
        } // first vstack
        
        .background(
            VStack {
                Color("color")
                Color("color1")
            }
            .ignoresSafeArea(.all, edges: .all)
        )
        
        //fetching album data
        .onAppear(perform: homeData.fetchAlbum)
        .onReceive(timer) { (_) in
            homeData.updateTimer()
        }
    }
    
    // Buttons...
    var buttons = ["suit.heart.fill", "star.fill", "eye.fill", "square.and.arrow.up.fill"]
}

