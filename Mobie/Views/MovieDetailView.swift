//
//  MovieDetailView.swift
//  Mobie
//
//  Created by Miguel Planckensteiner on 11.06.20.
//  Copyright © 2020 Miguel Planckensteiner. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            
            if movieDetailState.movie != nil {
                MovieDetailListView(movie: self.movieDetailState.movie!)
                
            }
        }
        //.navigationBarTitle(movieDetailState.movie?.title ?? "")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    
    @ObservedObject private var movieDetailState = MovieDetailState()

    
    let movie: Movie
    @State private var selectedTrailer: MovieVideo?
    let imageLoader = ImageLoader()
    
    // for sticky header view...
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    
    @State var show = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    GeometryReader { g in
                        
                        ZStack {
                            MovieDetailImage(imageLoader: self.imageLoader, imageURL: self.movie.backdropURL)
                                .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                                .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 2.2 + g.frame(in: .global).minY  : UIScreen.main.bounds.height / 2.2)
                                
                                .onReceive(self.time) { (_) in
                                    
                                    // its not a timer...
                                    // for tracking the image is scrolled out or not...
                                    
                                    let y = g.frame(in: .global).minY
                                    
                                    if -y > (UIScreen.main.bounds.height / 2.2) - 50{
                                        
                                        withAnimation{
                                            
                                            self.show = true
                                        }
                                    }
                                    else{
                                        
                                        withAnimation{
                                            
                                            self.show = false
                                        }
                                    }
                            }
                            
                            
                            Text(self.movie.title)
                                .font(.title)
                                .fontWeight(.bold)
                            
                                
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height / 2.2)
                    
                    VStack {
                        
                        HStack(alignment: .center) {
                            Text(movie.genreText)
                            Text("·")
                            Text(movie.yearText)
                            Text(movie.durationText)
                        }
                        .padding(.trailing)
                        .padding()
                        
                        Text(movie.overview)
                        HStack {
                            if !movie.ratingText.isEmpty {
                                Text(movie.ratingText).foregroundColor(.yellow)
                            }
                            Text(movie.scoreText)
                        }
                        
                        Divider()
                        
                        HStack(alignment: .top, spacing: 4) {
                            if movie.cast != nil && movie.cast!.count > 0 {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Starring").font(.headline)
                                    ForEach(self.movie.cast!.prefix(9)) { cast in
                                        Text(cast.name)
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                Spacer()
                                
                            }
                            
                            if movie.crew != nil && movie.crew!.count > 0 {
                                VStack(alignment: .leading, spacing: 4) {
                                    if movie.directors != nil && movie.directors!.count > 0 {
                                        Text("Director(s)").font(.headline)
                                        ForEach(self.movie.directors!.prefix(2)) { crew in
                                            Text(crew.name)
                                        }
                                    }
                                    
                                    if movie.producers != nil && movie.producers!.count > 0 {
                                        Text("Producer(s)").font(.headline)
                                            .padding(.top)
                                        ForEach(self.movie.producers!.prefix(2)) { crew in
                                            Text(crew.name)
                                        }
                                    }
                                    
                                    if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                                        Text("Screenwriter(s)").font(.headline)
                                            .padding(.top)
                                        ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                            Text(crew.name)
                                        }
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        Divider()
                        
                        if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                            Text("Trailers").font(.headline)
                            
                            ForEach(movie.youtubeTrailers!) { trailer in
                                Button(action: {
                                    self.selectedTrailer = trailer
                                }) {
                                    HStack {
                                        Text(trailer.name)
                                        Spacer()
                                        Image(systemName: "play.circle.fill")
                                            .foregroundColor(Color(UIColor.systemBlue))
                                    }
                                }
                            }
                        }
                    }
                    .sheet(item: self.$selectedTrailer) { trailer in
                        SafariView(url: trailer.youtubeURL!)
                    }
                }//: VSTACK
            }
        }//:ZStack
            .edgesIgnoringSafeArea(.top)
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
            //.aspectRatio(16/9, contentMode: .fit)
            .onAppear {
                self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id)
        }
    }
}
