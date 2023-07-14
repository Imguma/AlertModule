//
//  AlertManager.swift
//  AlertModule
//
//  Created by 애니모비 on 2023/07/14.
//

import Foundation

class AlertManager: ObservableObject {
    static let shared = AlertManager()
    
    private init() {}
    
    @Published var showAlert = false
    @Published var showAlertWithRequest1 = false
    @Published var showAlertWithRequest2 = false
    @Published var showAlertWithDownload = false
    @Published var message = ""
}
