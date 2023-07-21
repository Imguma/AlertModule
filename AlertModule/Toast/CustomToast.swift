//
//  CustomToast.swift
//  AlertModule
//
//
import SwiftUI

// custom toast
public struct CustomToast: View {
    
    public let toast: Toast
    
    @Environment(\.presentationMode) var presentationMode
    @Binding public var showToast: Bool
    
    public init(toast: Toast, showToast: Binding<Bool>) {
        self.toast = toast
        self._showToast = showToast
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(toast.message)
            }
            .font(.system(size: 15))
            .foregroundColor(Color.white)
            .frame(width: 150, height: 30)
            .background(Color.gray)
            .opacity(0.8)
            .cornerRadius(14)
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 37, trailing: 0))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.showToast = false
                }
            }
        }
        .onDisappear {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

public struct Overlay<T: View>: ViewModifier {
    @Binding var show: Bool
    let overlayView: T
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                overlayView
            }
        }
    }
}
