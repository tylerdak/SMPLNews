//
//  SearchView.swift
//  News
//
//  Created by Tyler Dakin on 4/15/20.
//  Copyright © 2020 Tyler Dakin. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @Binding var searchTerm: String
    @Binding var isPresented: Bool
    @Binding var country: String
    var spinnerChanger: (Bool) -> Void
    var networkManager: NetworkManager
    var body: some View {
        VStack {
            Spacer()
            Text("Enter Search Query:")
                .bold()
                .font(.system(size: CGFloat(25.0)))
            HStack {
                TextField(" Search Terms", text: self.$searchTerm)
                    .background(Color(UIColor.systemFill))
                    .mask(RoundedRectangle(cornerRadius: CGFloat(4.0)))
                Button(action: {
                    self.searchTerm = ""
                }) {
                    Text("Clear")
                }
            }.padding(.horizontal)
            Button(action: {
                self.networkManager.fetchData(searchTerm: self.searchTerm, completionHandler: self.spinnerChanger)
                self.isPresented = false
            }) {
                Text("Done")
            }
            Spacer()
            
            Spacer()
            Text("Country:")
            .bold()
            .font(.system(size: CGFloat(25.0)))
            Picker("", selection: $country) {
                ForEach(0..<20) { _ in
                    Text("AMERICA")
                }
            }
            .scaledToFit()
            .background(Color(UIColor.systemFill))
            .mask(RoundedRectangle(cornerRadius: CGFloat(10.0)))
            
            Spacer()
            Spacer()
        }.padding(.all)
    }
}
