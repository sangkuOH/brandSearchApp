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
                Text("작성일: \(item.datetime.toDate())")
                    .font(.title3)
                
                Link(destination: URL(string: item.doc_url)!) {
                    Text("출처: \(item.display_sitename)")
                        .font(.caption)
                        .underline()
                }
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
                    Text("작성일: \(item.datetime.toDate())")
                        .font(.title3)
                    
                    Link(destination: URL(string: item.doc_url)!) {
                        Text("출처: \(item.display_sitename)")
                            .font(.caption)
                            .underline()
                    }
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: Documents(
            collection: "collection",
            thumbnail_url: "https://w.namu.la/s/c04afeb0e8d1bfaa8a8f6cb1fd2c2eea5c7c8375e75f62f17d444a8de4eb8ea965c74c13a2b0a2d5c85bac55f6693e3450f11277c97bba5e161bfbe551c77622761e91e8e6821bc702c30d752c01a5838ed03dc0db111980cde9425a0d540d1e",
            image_url: "https://w.namu.la/s/c04afeb0e8d1bfaa8a8f6cb1fd2c2eea5c7c8375e75f62f17d444a8de4eb8ea965c74c13a2b0a2d5c85bac55f6693e3450f11277c97bba5e161bfbe551c77622761e91e8e6821bc702c30d752c01a5838ed03dc0db111980cde9425a0d540d1e",
            width: 300,
            height: 300,
            display_sitename: "Aimyon",
            doc_url: "http://blog.naver.com/sjhsjh0505/222531786900",
            datetime: "2021-10-09T13:30:00.000+09:00")
        )
    }
}
