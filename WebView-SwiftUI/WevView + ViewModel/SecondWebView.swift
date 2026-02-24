//
//  WebView2.swift
//  WebView-SwiftUI
//
//  Created by Salah Khaled on 24/02/2026.
//


import SwiftUI
import WebKit

struct SecondWebView: UIViewRepresentable {
    
    @ObservedObject var viewModel: WebViewModel
    
    func makeUIView(context: Context) -> WKWebView {
        viewModel.getWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
