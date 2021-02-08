//
//  MovieListView.swift
//  Mobie
//
//  Created by Miguel Planckensteiner on 11.06.20.
//  Copyright © 2020 Miguel Planckensteiner. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
    
    //MARK: - Properties
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upcomingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    @ObservedObject var movieSearchState = MovieSearchState()
    
    @State private var showingSettingsView: Bool = false

    
    init() {
        
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(named: "ColorBackground")
        UITableView.appearance().backgroundColor = UIColor(named: "ColorBackground")
    }
    
    
    
    //MARK: - BODY
    var body: some View {
        
        NavigationView {
            
            
            List {
                
                //MARK: - SEARCHBAR
                
                SearchBarView(placeholder: "Search Movies", text: self.$movieSearchState.query)
                   
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                LoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                
                if self.movieSearchState.movies != nil {
                    ForEach(self.movieSearchState.movies!) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                Text(movie.yearText)
                            }
                        }
                    }
                }
                
                //MARK: - GROUPS
                
                Group {
                    if nowPlayingState.movies != nil {
                        MoviePosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies!)
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if upcomingState.movies != nil {
                        MovieBackdropCarusellView(title: "Upcoming", movies: upcomingState.movies!)
                    } else {
                        LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                            self.upcomingState.loadMovies(with: .upcoming)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if topRatedState.movies != nil {
                        MovieBackdropCarusellView(title: "Top Rated", movies: topRatedState.movies!)
                    } else {
                        LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                            self.topRatedState.loadMovies(with: .topRated)
                        }
                    }
                    
                }

                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                
                Group {
                    if popularState.movies != nil {
                        MovieBackdropCarusellView(title: "Popular", movies: popularState.movies!)
                    } else {
                        LoadingView(isLoading: popularState.isLoading, error: popularState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                
            }
        
            .onAppear {
                self.movieSearchState.startObserve()
            }
                
            .navigationBarTitle("Mobie", displayMode: .large)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingSettingsView.toggle()
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 40, height: 40)
                            .accentColor(.white)
                            .cornerRadius(10)
                        
                        Image("Menu")
                            .renderingMode(.original)
                            .padding(.leading, 0)
                    }
                    
                }
                .sheet(isPresented: $showingSettingsView) {
                    MobieSettings()
                }
            )
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upcomingState.loadMovies(with: .upcoming)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
            
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

