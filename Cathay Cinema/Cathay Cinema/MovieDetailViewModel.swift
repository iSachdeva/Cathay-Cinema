//
//  MovieDetailViewModel.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class MovieDetailViewModel: NSObject {

    let networkManager = NetworkManager()

    var selectedMovie:Movie?
    var movieDetail:MovieDetail?
    
    
    func movieName() -> String {
    
        guard let name = self.movieDetail?.originalTitle else {
            return ""
        }
        return name
    }
    
    func generes() -> String {
    
        guard let generes = self.movieDetail?.generes, generes.count > 0 else {
            return ""
        }
        
        let generString = generes.enumerated().reduce("") {
            (wholeString: String, indexAndObj: (Int, Generes)) -> String in
            let separator = (indexAndObj.0 == generes.count - 1) ? "" : "| "
            return "\(wholeString)\(indexAndObj.1.name!) \(separator)"
        }
        
        return generString
    }
    
    func originalLanguage() -> String {
        guard let languageCode = self.movieDetail?.originalLanguage else {
            return "Language: --"
        }
        
        var language = ""
        switch languageCode {
        case "en":
            language = "English"
            break
        case "fr":
            language = "French"
            break
        case "xx":
            language = "Unknown"
            break
            
        default:
            language = languageCode
        }
        
        return "Language: \(language)"
    }
    
    func duration() -> String {
    
        guard let duration = self.movieDetail?.runTime else {
            return "Duration: --"
        }
        
        return "Duration: \(String(duration)) mins"
    }
    
    func overview() -> String {
        
        guard let overview = self.movieDetail?.overview else {
            return ""
        }
        
        return overview
    }
    
    func popularity() -> Double {
        guard let popularity = self.selectedMovie?.popularity else {
            return 0.0
        }
        
        return popularity
    }
    
    func loadImage(imageView:UIImageView) {
    
        let placeHolderImage = UIImage(named: "MovieListPlaceholder")
        imageView.contentMode = .center

        guard let posterName = self.movieDetail?.posterPath else {
            imageView.image = placeHolderImage
            return
        }
        
        let imageUrl = URL(string: Constant.URL.imageBaseUrl + Constant.ImageConfiguration.w500 + "/\(posterName)")!
        imageView.af_setImage(withURL: imageUrl, placeholderImage: placeHolderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: { (image) in
                imageView.contentMode = .scaleToFill
        })
    }
    
    func loadMovieDetail(completionHandler:@escaping (Bool)->()) {

        self.networkManager.getMovieDetail(forMovie: (self.selectedMovie?.id)!) { [unowned self] (isSuccess, movieDetailResponse, error) in
            
            if isSuccess {
                self.movieDetail = movieDetailResponse
            }
            completionHandler(isSuccess)
        }
    }
    
    
}
