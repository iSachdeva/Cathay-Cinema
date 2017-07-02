//
//  MovieDetailResponse.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieDetail:Mappable {
    
    var adult:Bool?
    var backdropPath:String?
    var belongsToCollection:String?
    var budget:String?
    
    var homePage:String?
    var id:Int?
    var imdbID:String?
    var originalLanguage:String?
    var originalTitle:String?
    var overview:String?
    var popularity:Double?
    var posterPath:String?
    var releaseDate:String?
    var revenue:String?
    var runTime:String?
    var status:String?
    var tagLine:String?
    var title:String?
    var video:Bool?
    var voteAverage:Double?
    var voteCount:Double?
    
    var generes:[Generes]?
    var productionCompanies:[ProductionCompany]?
    var productionCountries:[ProductionCountry]?
    var spokenLanguages:[SpokenLanguage]?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        self.adult <- map["adult"]
        self.backdropPath <- map["backdrop_path"]
        self.belongsToCollection <- map["belongs_to_collection"]
        self.budget <- map["budget"]
        self.homePage <- map["homepage"]
        self.id <- map["id"]
        self.imdbID <- map["imdb_id"]
        self.originalLanguage <- map["original_language"]
        self.originalTitle <- map["original_title"]
        self.overview <- map["overview"]
        self.popularity <- map["popularity"]
        self.posterPath <- map["poster_path"]
        self.releaseDate <- map["release_date"]
        self.revenue <- map["revenue"]
        self.runTime <- map["runtime"]
        self.status <- map["status"]
        self.tagLine <- map["tagline"]
        self.title <- map["title"]
        self.video <- map["video"]
        self.voteAverage <- map["vote_average"]
        self.voteCount <- map["vote_count"]
        self.generes <- map["genres"]
        self.productionCompanies <- map["production_companies"]
        self.productionCountries <- map["production_countries"]
        self.spokenLanguages <- map["spoken_languages"]
        
    }
}

class Generes: Mappable {
    
    var id:Int?
    var name:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
    }
}

class ProductionCompany: Mappable {
    
    var id:Int?
    var name:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.name <- map["name"]
    }
}

class ProductionCountry: Mappable {
    
    var iso:String?
    var name:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.iso <- map["page"]
        self.name <- map["name"]
    }
}

class SpokenLanguage: Mappable {
    
    var iso:String?
    var name:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.iso <- map["page"]
        self.name <- map["name"]
    }
}

