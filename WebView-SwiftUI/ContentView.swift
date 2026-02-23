//
//  ContentView.swift
//  WebView-SwiftUI
//
//  Created by Salah Khaled on 23/02/2026.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    @State private var isLoading = false
    @State private var webView: WKWebView? = nil
    private let homeURL = URL(string: "https://www.google.com")!
    
    var body: some View {
        ZStack {
            // WebView
            WebView(webView: $webView, url: homeURL)
                .set(loading: $isLoading)
                .set(navigationPolicy: { _ in .allow })
//                .set(webView: $webView)
                .ignoresSafeArea(edges: [.bottom, .leading, .trailing])
            
            // Loader
            if isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                
                ProgressView()
                    .padding()
                    .background(.thickMaterial)
                    .cornerRadius(12)
            }
            // Controls
            VStack {
                Spacer()
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.7),
                        Color.black.opacity(0.5),
                        Color.clear
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
                .frame(height: 80)
                .blur(radius: 36)
                .edgesIgnoringSafeArea(.bottom)
                .overlay(
                    // Controls
                    HStack(spacing: 12) {
                        
                        Button {
                            webView?.reload()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.black)
                                .padding(12)
                                .background(.white)
                                .cornerRadius(.infinity)
                                .aspectRatio(1, contentMode: .fit)
                        }
                        
                        HStack(spacing: 12) {
                            Button {
                                webView?.goBack()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.black)
                                    .padding(12)
                                    .frame(maxWidth: .infinity)
                                    .background(.white)
                                    .cornerRadius(.infinity)
                            }
                            .disabled(!(webView?.canGoBack ?? false))
                            .opacity((webView?.canGoBack ?? false) ? 1 : 0.5)
                            
                            Button {
                                webView?.goForward()
                            } label: {
                                Image(systemName: "chevron.forward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.black)
                                    .padding(12)
                                    .frame(maxWidth: .infinity)
                                    .background(.white)
                                    .cornerRadius(.infinity)
                            }
                            .disabled(!(webView?.canGoForward ?? false))
                            .opacity((webView?.canGoForward ?? false) ? 1 : 0.5)
                        }
                        .frame(maxHeight: .infinity)
                        
                        Button {
                            webView?.load(URLRequest(url: homeURL))
                        } label: {
                            Image(systemName: "house")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.black)
                                .padding(12)
                                .background(.white)
                                .cornerRadius(.infinity)
                        }
                    }
                        .padding(.horizontal, 50)
                        .frame(height: 40),
                    alignment: .center
                )
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
