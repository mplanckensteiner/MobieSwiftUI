//
//  FormRowLinkView.swift
//  Mobie
//
//  Created by Miguel Planckensteiner on 15.06.20.
//  Copyright © 2020 Miguel Planckensteiner. All rights reserved.
//

import SwiftUI

struct FormRowLinkView: View {
    // MARK: - Properties
     var icon: String
     var color: Color
     var text: String
     var link: String
    
    var body: some View {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(color)
                    Image(icon)
                        .foregroundColor(Color.white)
                    
                }
                .frame(width: 36, height: 36, alignment: .center)
                
                Text(text).foregroundColor(Color.gray)
                
                Spacer()
                
                Button(action: {
                    //Opent the link
                    guard let url = URL(string: self.link),
                        UIApplication.shared.canOpenURL(url) else {
                            return
                    }
                    UIApplication.shared.open(url as URL)
                }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                .accentColor(Color(.systemGray2))
            }
        }
    }

struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "gear", color: Color.pink, text: "Website", link: "https://www.google.com")
        .previewLayout(.fixed(width: 375, height: 60))
        .padding()
    }
}
