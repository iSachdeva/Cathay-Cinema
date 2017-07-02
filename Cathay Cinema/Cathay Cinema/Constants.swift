//
//  Constants.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import Foundation

struct Constant {

    struct PrivateKey {
        static let restAPI = "cf52773d273bb5db91a0a99c73890502"
    }
    
    struct ImageConfiguration {
        static let w500 = "w500"
    }
    
    struct URL {
        static let baseUrl = "https://api.themoviedb.org/"
        static let movieList = "3/discover/movie"
        static let movieDetail = "3/movie"
        static let imageBaseUrl = "https://image.tmdb.org/t/p/"
        static let bookingUrl = "https://www.cathaycineplexes.com.sg/"
    }
    
    struct Segue {
        static let MovieListToMovieDetailScreenID = "MovieListToMovieDetailScreenID"
        static let MovieDetailToBookingWebScreenID = "MovieDetailToBookingWebScreenID"
        
    }
}
