//
//  WebViewModel.swift
//  WebView-SwiftUI
//
//  Created by Salah Khaled on 24/02/2026.
//


import Foundation
import WebKit
import Combine

final class WebViewModel: NSObject, ObservableObject {
    
    // MARK: - Published State
    @Published var isLoading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    
    // MARK: - Properties
    private let webView: WKWebView
    private let homeURL = URL(string: "https://www.apple.com")!
    
    // MARK: - Init
    override init() {
        self.webView = WKWebView()
        super.init()
        self.webView.navigationDelegate = self
    }
    
    // MARK: - Public Actions
    func getWebView() -> WKWebView {
        webView
    }
    
    func load(_ url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    func reload() {
        webView.reload()
    }
    
    func back() {
        webView.goBack()
    }
    
    func forward() {
        webView.goForward()
    }
    
    func home() {
        self.load(homeURL)
    }
}

// MARK: - Extension
extension WebViewModel: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        isLoading = true
        updateNavigationState()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
        updateNavigationState()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        isLoading = false
        updateNavigationState()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    private func updateNavigationState() {
        canGoBack = webView.canGoBack
        canGoForward = webView.canGoForward
    }
}


