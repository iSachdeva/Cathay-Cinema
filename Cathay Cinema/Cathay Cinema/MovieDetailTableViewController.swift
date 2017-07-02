//
//  MovieDetailTableViewController.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import UIKit
import Cosmos
import KVNProgress

class MovieDetailTableViewController: UITableViewController {

    @IBOutlet var viewModel:MovieDetailViewModel!
    
    @IBOutlet var popularityView:CosmosView!
    @IBOutlet var posterImageView:UIImageView!
    @IBOutlet var generesLabel:UILabel!
    @IBOutlet var languageLabel:UILabel!
    @IBOutlet var durationLabel:UILabel!
    @IBOutlet var movieTitleLabel:UILabel!
    @IBOutlet var overviewLabel:UILabel!
    
    var movie:Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 400
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.viewModel.selectedMovie = self.movie
        
        KVNProgress.show()
        self.viewModel.loadMovieDetail { (isSuccess) in
            if isSuccess {
                KVNProgress.dismiss(completion: {
                    self.populateMovieDetails()
                    self.tableView.reloadData()
                })
            } else {
                KVNProgress.dismiss(completion: {
                    KVNProgress.showError()
                })
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
        self.popularityView.rating = self.viewModel.popularity()
        self.viewModel.loadImage(imageView: self.posterImageView)
        self.overviewLabel.text = self.viewModel.overview()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            guard let _ = self.viewModel.movieDetail else {
                return
            }
            self.performSegue(withIdentifier: Constant.Segue.MovieDetailToBookingWebScreenID, sender: nil)
        }
    }
    
}


