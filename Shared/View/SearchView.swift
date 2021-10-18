//
//  SearchView.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/15.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchViewModel = SearchViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var serachBar: some View {
        TextField("Search..", text: $searchViewModel.inputText)
            .textFieldStyle(.roundedBorder)
            .overlay(
                Button {
                    searchViewModel.inputText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.trailing, 10)
                        .foregroundColor(.secondary)
                },
                alignment: .trailing
            )
            .padding()
            .onReceive(searchViewModel.debouncedText) { value in
                searchViewModel.page = 1
                searchViewModel.data = nil
                
                if !value.isEmpty {
                    searchViewModel.fetchData()
                }
            }
    }
    
    var loadingView: some View {
        VStack {
            Spacer()
            
            ProgressView("Loading...")
                .font(.headline)
                .progressViewStyle(.circular)
                .foregroundColor(.yellow)
                .tint(.blue)
            
                .frame(width: 300, height: 300)
            
            Spacer()
        }
    }
    
    var defaultView: some View {
        VStack {
            Spacer()
            
            Image(systemName: "magnifyingglass.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("Search!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .foregroundColor(.secondary)
    }
    
    var noResult: some View {
        VStack {
            Spacer()
            
            Text("검색 결과가 없습니다")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .foregroundColor(.secondary)
    }
    
    @ViewBuilder
    var GridView: some View {
        if let data = searchViewModel.data,
           !data.documents.isEmpty {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(Array(data.documents.enumerated()), id: \.offset) { index, item in
                        NavigationLink {
                            DetailView(item: item)
                        } label: {
                            AsyncImage(url: URL(string: item.thumbnail_url)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.secondary)
                            }
                        }
                        .task {
                            if index == data.documents.count - 1 {
                                searchViewModel.fetchData()
                            }
                        }
                    }
                }
            }
        } else {
            noResult
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                serachBar
                
                switch searchViewModel.inputText.isEmpty {
                case true:
                    defaultView
                case false:
                    switch searchViewModel.isLoading && searchViewModel.data == nil {
                    case true:
                        loadingView
                    case false:
                        if searchViewModel.data == nil {
                            noResult
                        } else {
                            GridView
                        }
                    }
                }
            }
            .navigationTitle("Brandi Seach App")
            .edgesIgnoringSafeArea(.bottom)
            .alert(isPresented: $searchViewModel.isError) {
                Alert(
                    title: Text("Error!"),
                    message: Text(searchViewModel.errorMessage)
                )
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
