//
//  MoviesListViewController.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import UIKit
import KVNProgress

class MoviesListViewController: UIViewController {
    
    @IBOutlet var moviesCollectionView:UICollectionView!
    @IBOutlet var viewModel:MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesCollectionView.addSubview(self.refreshControl)
        self.loadMovies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MoviesListViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.viewModel.clearMovieList()
        self.moviesCollectionView.reloadData()
        self.loadMovies()
    }
    
    func loadMovies() {
        
        KVNProgress.show()
        self.viewModel.loadMoviesList { [unowned self] (isSuccess:Bool) in
            KVNProgress.dismiss(completion: {
                if isSuccess {
                    self.moviesCollectionView.reloadData()
                } else {
                    KVNProgress.showError()
                }
                self.refreshControl.endRefreshing()
            })
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MoviesListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return viewModel.itemForRow(at: indexPath, for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (self.viewModel.numberOfRows()-1 == indexPath.row) && (self.viewModel.isLastPageLoaded == false) && (self.viewModel.isLoadingList == false) {
            self.loadMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedMovie = self.viewModel.movie(at: indexPath.row) {
            self.performSegue(withIdentifier: Constant.Segue.MovieListToMovieDetailScreenID, sender: selectedMovie)
        }
    }
}

extension MoviesListViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.sizeOfItem(inView: self.view)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.viewModel.inset(forSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return self.viewModel.minimumLineSpacing(for: section)
    }
}

extension MoviesListViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.Segue.MovieListToMovieDetailScreenID {
        
            let movieDetailViewController = segue.destination as! MovieDetailTableViewController
            movieDetailViewController.movie =  sender as? Movie
    
        }
    }

}

