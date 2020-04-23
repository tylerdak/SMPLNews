//
//  ContentView.swift
//  News
//
//  Created by Tyler Dakin on 4/13/20.
//  Copyright © 2020 Tyler Dakin. All rights reserved.
//  Several portions of this code have been copied from the London App Brewery
//  iOS 13 App Development course, Hacker News Client SWIFTUI Project.

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State var showShareSheet = false
    @State var showingSearchAlert = false
    @State var searchTerm: String = ""
    @State var spinnerIsVisible = false
    @State var country: String = "AMERICA"
    var body: some View {
        NavigationView {
            List(networkManager.articles) { (post) in
                NavigationLink(destination: WebMaker(post: post, showShareSheet: self.showShareSheet).navigationBarTitle(Text(post.title),displayMode: .inline)){
                    Text(post.title)
                    
                }
            }
                .navigationBarTitle("Simp News")
                .navigationBarItems(leading:
                    Button(action: {
                        self.searchTerm = ""
                        self.networkManager.fetchData(searchTerm: self.searchTerm, completionHandler: self.changeSpinnerAnimation)
                    }) {
                        Image(systemName: "arrow.clockwise")
                        .resizable()
                        .scaleEffect(CGFloat(1.4))
                    }
                ,trailing:
                    Button(action: {
                        self.showingSearchAlert = true
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaleEffect(CGFloat(1.4))
                    }
                    .popover(isPresented: $showingSearchAlert) {
                        SearchView(searchTerm: self.$searchTerm, isPresented: self.$showingSearchAlert, country: self.$country, spinnerChanger: self.changeSpinnerAnimation, networkManager: self.networkManager)
                    }
                    .onDisappear(perform: {
                        self.networkManager.fetchData(searchTerm: self.searchTerm, completionHandler: self.changeSpinnerAnimation)
                    })
                )
        
            
        }
        .onAppear {
            self.networkManager.fetchData(searchTerm: self.searchTerm, completionHandler: self.changeSpinnerAnimation)
        }
        .overlay(ProgressHUD(isAnimating: $spinnerIsVisible))
    }
    
    func changeSpinnerAnimation(shouldBeSpinning: Bool) {
        spinnerIsVisible = shouldBeSpinning
        print("Spinner Animating: \(spinnerIsVisible)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WebMaker: View {
    var post: Article
    @State var showShareSheet: Bool
    var body: some View {
        WebView(urlString: post.url)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .scaleEffect(CGFloat(1.4))
                }
                .sheet(isPresented: $showShareSheet, content: {
                    ShareSheet(url: URL(string: self.post.url)!).edgesIgnoringSafeArea(.bottom)
                })
        )
    }
}
