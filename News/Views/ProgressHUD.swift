//
//  ProgressHUD.swift
//  News
//
//  Created by Tyler Dakin on 4/15/20.
//  Copyright © 2020 Tyler Dakin. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct ProgressHUD: UIViewRepresentable {
    @Binding var isAnimating: Bool
    var spinner = UIActivityIndicatorView(style: .large)
    func makeUIView(context: UIViewRepresentableContext<ProgressHUD>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ProgressHUD>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
