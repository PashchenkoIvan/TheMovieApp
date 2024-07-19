//
//  TrendingCollectionView.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 19.07.2024.
//

import Foundation
import UIKit
import Kingfisher

extension GeneralViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return generalLogic.trendingMovieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMovie = generalLogic.trendingMovieArray[indexPath.row]
        let url = URL(string: "\(DefaultValues.defaultImageUrl)\(currentMovie.backdropPath!)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
        
        cell.movieImage.kf.setImage(with: url)
        cell.movieTitle.text = currentMovie.title ?? ""
        cell.voteAverage.text = String(currentMovie.voteAverage ?? 0.0)
        cell.movieDescription.text = currentMovie.overview ?? ""
        
        return cell
    }
}

extension GeneralViewController: UICollectionViewDelegate {
    
}
