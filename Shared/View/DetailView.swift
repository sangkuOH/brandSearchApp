//
//  DetailView.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/15.
//

import SwiftUI

struct DetailView: View {
    @State private var contentHeight: CGFloat = 0
    let item: Documents
    let screenHeight = UIScreen.main.bounds.height
    
    
    var baseContent: some View {
        VStack {
            AsyncImage(url: URL(string: item.image_url)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
            }
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            self.contentHeight = proxy.size.height
                        }
                }
            )
            
            Group {
                Text(item.display_sitename)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    
                Text(item.datetime.toDate())
                    .font(.title3)
            }
            .foregroundColor(.secondary)
        }
    }
    var scrollContent: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: item.image_url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
                Group {
                    Text(item.display_sitename)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                    Text(item.datetime.toDate())
                        .font(.title3)
                }
                .foregroundColor(.secondary)
            }
        }
    }
    
    var body: some View {
        if contentHeight < screenHeight / 2 {
         baseContent
        } else {
            scrollContent
        }
    }
}
//
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(item: Item(label: "car", image: "car"))
//    }
//}
