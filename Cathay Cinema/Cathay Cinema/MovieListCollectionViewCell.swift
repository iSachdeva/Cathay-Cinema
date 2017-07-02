//
//  MovieListCollectionViewCell.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import Foundation
import UIKit
import Cosmos
import Alamofire
import AlamofireImage

class MovieListCollectionViewCell:UICollectionViewCell {
    
    @IBOutlet var name:UILabel!
    @IBOutlet var popularityView:CosmosView!
    @IBOutlet var posterView:UIImageView!
    
    func load(item movie:Movie?) {
        
        guard let movieItem = movie else {
            self.name.text = ""
            self.popularityView.rating = 0.0
            return
        }
        if let title = movieItem.originalTitle {
            self.name.text = title
        } else {
            self.name.text = ""
        }
        
        if let popularity = movieItem.popularity {
            self.popularityView.rating = popularity
        } else {
            self.popularityView.rating = 0.0
        }
        
        self.posterView.image = nil
        let placeHolderImage = UIImage(named: "MovieListPlaceholder")
        self.posterView.contentMode = .center
        if let posterName = movieItem.posterPath {
            let imageUrl = URL(string: Constant.URL.imageBaseUrl + Constant.ImageConfiguration.w500 + "/\(posterName)")!
            self.posterView.af_setImage(withURL: imageUrl, placeholderImage: placeHolderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: { (image) in
                self.posterView.contentMode = .scaleToFill
            })
        } else {
            self.posterView.image = placeHolderImage
            self.posterView.contentMode = .center
        }
    }
    
    
}
