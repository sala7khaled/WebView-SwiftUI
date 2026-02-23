//
//  WebView.swift
//  WebView-SwiftUI
//
//  Created by Salah Khaled on 23/02/2026.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    // MARK: - Properties
    @Binding var webView: WKWebView?
    var loadingBinding: Binding<Bool>? = nil
    var navigationPolicy: ((WKNavigationAction) -> WKNavigationActionPolicy)? = nil
    let url: URL
    
    // MARK: - View
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        
        DispatchQueue.main.async {
            self.webView = webView
        }
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
    
    // MARK: - Coordinator + Delegate
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        var parent: WebView

        
        init(parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.loadingBinding?.wrappedValue = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.loadingBinding?.wrappedValue = false
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.loadingBinding?.wrappedValue = false
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(parent.navigationPolicy?(navigationAction) ?? .allow)
        }
    }
}

// MARK: - Extension
extension WebView {
    
    func set(navigationPolicy: @escaping (WKNavigationAction) -> WKNavigationActionPolicy) -> WebView {
        var view = self
        view.navigationPolicy = navigationPolicy
        return view
    }
    
    func set(loading: Binding<Bool>) -> WebView {
        var view = self
        view.loadingBinding = loading
        return view
    }
    
    func set(webView: Binding<WKWebView?>) -> WebView {
        var view = self
        view._webView = webView
        return view
    }
    
    func home(webView: Binding<WKWebView?>) -> WebView {
        var view = self
        view._webView = webView
        return view
    }
}
