//
//  MoviesListViewController.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        refreshControl.addTarget(self, action: #selector(MoviesListViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.white
        return refreshControl
    }()
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.viewModel.clearMovieList()
        self.moviesCollectionView.reloadData()
        
        self.loadMovies()
    }
    
    func loadMovies() {
        self.viewModel.loadMoviesList { (isSuccess:Bool) in
            if isSuccess {
                self.moviesCollectionView.reloadData()
            }
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MoviesListViewController {
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


