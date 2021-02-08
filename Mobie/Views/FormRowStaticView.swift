//
//  FormRowStaticView.swift
//  Mobie
//
//  Created by Miguel Planckensteiner on 15.06.20.
//  Copyright © 2020 Miguel Planckensteiner. All rights reserved.
//

import SwiftUI

struct FormRowStaticView: View {
    //MARK: - Properties
       var icon: String
       var firstText: String
       var secondText: String
       
       //MARK: - Body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }
            .frame(width: 40, height: 40, alignment: .center)
            
            Text(firstText).foregroundColor(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}

struct FormRowStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Mobie")
            .previewLayout(.fixed(width: 375, height: 60))
        .padding()
    }
}
