//
//  GeneralViewControllerViewModel.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 17.07.2024.
//

import Foundation

//MARK: MovieView logic
class GeneralViewControllerViewModel {
    public var trendingMovieArray: [Movie] = []
    
    func updateTrendingMovieArray(completion: @escaping (() -> ())) {
        if NetworkHelper.hasInternetConnection() {
            // Getting trending movies
            RequestHelper.request(address: .getTrendMovies, params: .getTrendMovies(.init(requestType: .get, language: "en-US"))) { (response: Result<MovieListResponce, Error>) in
                switch response {
                    
                    // In case of success
                case .success(let result):
                    RealmCRUD.updateDatabase(dataType: DataBase.trend, response: result)
                    self.trendingMovieArray = result.results
                    
                    completion()
                    
                    // In case of error
                case .failure(let error):
                    print("Error with getting trending movies: \(error)")
                    
                    completion()
                }
            }
        } else {
            self.trendingMovieArray = RealmCRUD.getData(dataType: DataBase.trend)
        }
    }
}

