//
//  MovieListViewModel.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 2/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import Foundation
import UIKit

class MovieListViewModel:NSObject {
    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 10, bottom: 5.0, right: 10)
    fileprivate let cellIdentifier = "MovieCollectionViewCellIdentifier"

    let networkManager = NetworkManager()
    let moviesSortBy = "release_date.desc"
    var pageNumber = 0
    var movies = [Movie]()
    var isLastPageLoaded:Bool = false
    var isLoadingList = false
   
    func movie(at index:Int) -> Movie? {
        if self.movies.count >= index {
            return self.movies[index]
        } else {
            return nil
        }
    }
    
    func clearMovieList() {
        self.movies.removeAll()
        self.pageNumber = 0
    }

    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return self.movies.count
    }
    
    func sizeOfItem(inView view:UIView) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.65)
    }
    
    func inset(forSection section:Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func minimumLineSpacing(for section: Int) -> CGFloat {
        return self.sectionInsets.left
    }
    
    func itemForRow(at indexPath:IndexPath,for view:UICollectionView) -> UICollectionViewCell {
    
        let cell = view.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! MovieListCollectionViewCell
        cell.load(item: self.movies[indexPath.row])
        return cell
    }
    
    func checkIfLastPage(totalCount:Int?) {
    
        guard let totalCountOfPages = totalCount else {
            self.isLastPageLoaded = true
            return
        }
        
        if totalCountOfPages == self.movies.count {
            self.isLastPageLoaded = true
        } else {
            self.isLastPageLoaded = false
        }
    }
    
    func loadMoviesList(completionHandler:@escaping (Bool)->()) {
        self.isLoadingList = true
       
        self.networkManager.getMoviesList(forPage: (self.pageNumber + 1), sortBy:self.moviesSortBy, completionHandler: { [unowned self] (isSuccess,response,error) in
           
            if isSuccess {
                if let movies = response?.movies {
                    self.movies.append(contentsOf: movies)
                    self.pageNumber = self.pageNumber + 1
                    self.checkIfLastPage(totalCount: response?.totalPages)
                    self.isLoadingList = false
                }
            }
            completionHandler(isSuccess)
        })
    }
}
