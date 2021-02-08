//
//  MovieBackdropCarusellView.swift
//  Mobie
//
//  Created by Miguel Planckensteiner on 11.06.20.
//  Copyright © 2020 Miguel Planckensteiner. All rights reserved.
//

import SwiftUI

struct MovieBackdropCarusellView: View {
    //MARK: - Properties
    
    let title: String
    let movies: [Movie]
    
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack (alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            MovieBackDropCard(movie: movie)
                                .frame(width:272, height: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

struct MovieBackdropCarusellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCarusellView(title: "Latest", movies: Movie.stubbedMovies)
    }
}
