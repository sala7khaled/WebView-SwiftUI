//
//  SecondView.swift
//  WebView-SwiftUI
//
//  Created by Salah Khaled on 24/02/2026.
//

import SwiftUI

struct SecondView: View {
    
    @StateObject private var viewModel = WebViewModel()
    
    var body: some View {
        ZStack {
            
            SecondWebView(viewModel: viewModel)
                .ignoresSafeArea(edges: [.bottom, .leading, .trailing])
            
            if viewModel.isLoading {
                Color.black.opacity(0.3).ignoresSafeArea()
                
                ProgressView()
                    .padding()
                    .background(.thickMaterial)
                    .cornerRadius(12)
            }
            
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
                        
                        Button { viewModel.reload() }
                        label: { controlIcon("arrow.clockwise") }
                        
                        Button { viewModel.back() }
                        label: { controlIcon("chevron.backward") }
                            .disabled(!viewModel.canGoBack)
                            .opacity(viewModel.canGoBack ? 1 : 0.5)
                        
                        Button { viewModel.forward() }
                        label: { controlIcon("chevron.forward") }
                            .disabled(!viewModel.canGoForward)
                            .opacity(viewModel.canGoForward ? 1 : 0.5)
                        
                        Button { viewModel.home() }
                        label: { controlIcon("house") }
                    }
                        .padding(.horizontal, 50)
                        .frame(height: 40),
                    alignment: .center
                )
            }
            .ignoresSafeArea()
        }
        .onAppear {
            viewModel.home()
        }
    }
    
        private func controlIcon(_ name: String) -> some View {
            Image(systemName: name)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundColor(.black)
                .padding(12)
                .background(.white)
                .cornerRadius(.infinity)
        }
}

#Preview {
    SecondView()
}
