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
        guard let language = self.movieDetail?.originalLanguage else {
            return "Language: --"
        }
        return "Language: \(language)"
    }
    
    func duration() -> String {
    
        return "Duration: --"
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
