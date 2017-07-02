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

        self.viewModel.loadMoviesList { (isSuccess:Bool) in
            if isSuccess {
                self.moviesCollectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
