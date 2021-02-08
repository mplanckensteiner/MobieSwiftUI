//
//  MoviePosterCard.swift
//  Mobie
//
//  Created by Miguel Planckensteiner on 11.06.20.
//  Copyright © 2020 Miguel Planckensteiner. All rights reserved.
//

import SwiftUI

struct MoviePosterCard: View {
    //MARK: - Properties
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    //MARK: - BODY
    var body: some View {
        VStack {
            
            VStack {
                
                Text(movie.title)
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                        .frame(width: 250, height: 300)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                    
                    Text(movie.title)
                        .multilineTextAlignment(.center)
                }
                
                Text(movie.yearText)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
            }
            .frame(width: 280, height: 350)
            .onAppear {
                self.imageLoader.loadImage(with: self.movie.posterURL)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.stubbedMovie)
    }
}
