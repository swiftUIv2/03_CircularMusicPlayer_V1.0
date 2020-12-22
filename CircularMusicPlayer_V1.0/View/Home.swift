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
    
    var body: some View {
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
                    
                    //Rotating View for bottom facing...
                    
                } //zstack
                // mid 90 deg + 0.1*360 = 36
                // total 126
                .rotationEffect(.init(degrees: 126))
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
            
            Spacer(minLength: 0)
        }
        //fetching album data
        .onAppear(perform: homeData.fetchAlbum)
    }
}

