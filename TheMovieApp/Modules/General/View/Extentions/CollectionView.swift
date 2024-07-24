//
//  TrendingCollectionView.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 19.07.2024.
//

import Foundation
import UIKit
import Kingfisher

let genres: [(name: String, color: UIColor, image: UIImage)] = [
    ("Action", .red.withAlphaComponent(0.5), UIImage(named: "action.jpg")!),
    ("Adventure", .orange.withAlphaComponent(0.5), UIImage(named: "adventure.jpg")!),
    ("Animation", .yellow.withAlphaComponent(0.5), UIImage(named: "animation.jpg")!),
    ("Comedy", .green.withAlphaComponent(0.5), UIImage(named: "comedy.jpg")!),
    ("Crime", .blue.withAlphaComponent(0.5), UIImage(named: "crime.jpg")!),
    ("Documentary", .cyan.withAlphaComponent(0.5), UIImage(named: "documentary.jpg")!),
    ("Drama", .purple.withAlphaComponent(0.5), UIImage(named: "drama.jpg")!),
    ("Family", .magenta.withAlphaComponent(0.5), UIImage(named: "family.jpg")!),
    ("Fantasy", .brown.withAlphaComponent(0.5), UIImage(named: "fantasy.jpg")!),
    ("History", .gray.withAlphaComponent(0.5), UIImage(named: "history.jpg")!),
    ("Horror", .black.withAlphaComponent(0.5), UIImage(named: "horror.jpg")!),
    ("Music", .systemPink.withAlphaComponent(0.5), UIImage(named: "music.jpg")!),
    ("Mystery", .darkGray.withAlphaComponent(0.5), UIImage(named: "mystery.jpg")!),
    ("Romance", .systemRed.withAlphaComponent(0.5), UIImage(named: "romance.jpg")!),
    ("Science Fiction", .systemBlue.withAlphaComponent(0.5), UIImage(named: "science_fiction.jpg")!),
    ("TV Movie", .systemTeal.withAlphaComponent(0.5), UIImage(named: "tv_movie.jpg")!),
    ("Thriller", .systemIndigo.withAlphaComponent(0.5), UIImage(named: "thriller.jpg")!),
    ("War", .systemGray.withAlphaComponent(0.5), UIImage(named: "war.jpg")!),
    ("Western", .systemOrange.withAlphaComponent(0.5), UIImage(named: "western.jpg")!)
]


extension GeneralViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendingCollectionView {
            return generalLogic.trendingMovieArray.count
        } else if collectionView == genresCollectionView {
            return generalLogic.genresArray.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == trendingCollectionView {
            let currentMovie = generalLogic.trendingMovieArray[indexPath.row]
            let url = URL(string: "\(DefaultValues.defaultImageUrl)\(currentMovie.backdropPath!)")
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
            
            cell.movieImage.kf.setImage(with: url)
            cell.movieTitle.text = currentMovie.title ?? ""
            cell.voteAverage.text = String(currentMovie.voteAverage ?? 0.0)
            cell.movieDescription.text = currentMovie.overview ?? ""
            
            return cell
        } else {
            let currentGenre = generalLogic.genresArray[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
            
            cell.genresTextLabel.text = currentGenre.name
            
            if let genre = genres.first(where: { $0.name == currentGenre.name }) {
                let backgroundImageView = UIImageView(image: genre.image)
                backgroundImageView.contentMode = .scaleAspectFill
                backgroundImageView.frame = cell.bounds
                cell.backgroundView = backgroundImageView
                
                cell.contentView.backgroundColor = genre.color
            } else {
                cell.contentView.backgroundColor = UIColor.systemPink.withAlphaComponent(0.5) // Default color if genre not found
            }
            
            print(currentGenre)
            
            return cell
        }
    }
}

extension GeneralViewController: UICollectionViewDelegate {
    
}
