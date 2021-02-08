//
//  MobieSettings.swift
//  Mobie
//
//  Created by Miguel Planckensteiner on 15.06.20.
//  Copyright © 2020 Miguel Planckensteiner. All rights reserved.
//

import SwiftUI

struct MobieSettings: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center, spacing: 0) {
                Form {
                    //MARK: - SECTION 1
                    Section(header: Text("Follow Me on Social Media")) {
                        FormRowLinkView(icon: "gear", color: Color.pink, text: "Instagram", link: "https://www.instagram.com/")
                        FormRowLinkView(icon: "gear", color: Color.blue, text: "Twitter", link: "https://twitter.com/")
                    }//: SECTION 1
                        .padding(.vertical, 3)
                    
                    //MARK: - SECTION 2
                    Section(header: Text("About Mobie")) {
                       FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Mobie")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Miguel Planckensteiner")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                        
                    }//: SECTION 2
                        .padding(.vertical, 3)
                    
                    
                }//: FORM
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                
                //MARK: - FOOTER
                
                Text("Copyright © All right reserved")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
                
                
            }//: VSTACK
                .navigationBarItems(trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
            )
                .navigationBarTitle("Settings", displayMode: .inline)
                .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        }//: NavigationView
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MobieSettings_Previews: PreviewProvider {
    static var previews: some View {
        MobieSettings()
    }
}
