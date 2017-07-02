//
//  Movies.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import Foundation
import ObjectMapper

class MoviesListResponse:Mappable {

    var page:Int?
    var totalResults:Int?
    var totalPages:Int?
    var movies:[Movie]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.page <- map["page"]
        self.totalResults <- map["total_results"]
        self.totalPages <- map["total_pages"]
        self.movies <- map["results"]
    }
}

class Movie:Mappable {

    var voteCount:Int?
    var id:Int?
    var video:Bool?
    var title:String?
    var popularity:Double?
    var posterPath:String?
    var originalLanguage:String?
    var originalTitle:String?
    var backdropPath:String?
    var adult:Bool?
    var overview:String?
    var releaseDate:String?
    var genreIds:[Int]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        self.voteCount <- map["vote_count"]
        self.id <- map["id"]
        self.video <- map["video"]
        self.title <- map["title"]
        self.popularity <- map["popularity"]
        self.posterPath <- map["poster_path"]
        self.originalLanguage <- map["original_language"]
        self.originalTitle <- map["original_title"]
        self.backdropPath <- map["backdrop_path"]
        self.adult <- map["adult"]
        self.overview <- map["overview"]
        self.releaseDate <- map["release_date"]
        self.genreIds <- map["genre_ids"]
        
    }

}
