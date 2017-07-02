//
//  MovieDetailTableViewController.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import UIKit
import Cosmos

class MovieDetailTableViewController: UITableViewController {

    @IBOutlet var viewModel:MovieDetailViewModel!
    
    @IBOutlet var popularityView:CosmosView!
    @IBOutlet var posterImageView:UIImageView!
    @IBOutlet var generesLabel:UILabel!
    @IBOutlet var languageLabel:UILabel!
    @IBOutlet var durationLabel:UILabel!
    @IBOutlet var movieTitleLabel:UILabel!
    
    var movie:Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.selectedMovie = self.movie
        
        self.viewModel.loadMovieDetail { (isSuccess) in
            if isSuccess {
                self.populateMovieDetails()
            } else {
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func populateMovieDetails() {
        self.languageLabel.text = self.viewModel.originalLanguage()
        self.generesLabel.text = self.viewModel.generes()
        self.durationLabel.text = self.viewModel.duration()
        self.movieTitleLabel.text = self.viewModel.movieName()
        self.viewModel.loadImage(imageView: self.posterImageView)
    }

}
