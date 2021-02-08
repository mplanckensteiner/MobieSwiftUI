//
//  SafariView.swift
//  Mobie
//
//  Created by Miguel Planckensteiner on 13.06.20.
//  Copyright © 2020 Miguel Planckensteiner. All rights reserved.
//

import SafariServices
import SwiftUI



struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        
        let safariVC = SFSafariViewController(url: self.url)
        return safariVC
    }
}
