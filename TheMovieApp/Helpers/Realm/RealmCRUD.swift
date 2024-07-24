//
//  RealmCRUD.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 18.07.2024.
//

import Foundation
import RealmSwift

enum MovieDataBase {
    case favorite
    case trend
}

enum DataBase {
    case movie(MovieDataBase)
    case genres
}

enum DataType {
    case Movie(MovieListResponce)
    case Genres(GenresResponce)
}

protocol MovieProtocol {
    var id: Int { get set }
    func setup(with movie: Movie)
}

protocol GenreProtocol {
    var id: Int { get set }
    func setup(with genre: Genre)
}

extension FavoriteMovieObj: MovieProtocol {
    func setup(with movie: Movie) {
        self.adult = movie.adult ?? false
        self.backdropPath = movie.backdropPath ?? ""
        self.id = movie.id ?? 0
        self.originalLanguage = movie.originalLanguage ?? ""
        self.originalTitle = movie.originalTitle ?? ""
        self.overview = movie.overview ?? ""
        self.popularity = movie.popularity ?? 0.0
        self.posterPath = movie.posterPath ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.title = movie.title ?? ""
        self.video = movie.video ?? false
        self.voteAverage = movie.voteAverage ?? 0.0
        self.voteCount = movie.voteCount ?? 0
    }
}

extension TrendMovieObj: MovieProtocol {
    func setup(with movie: Movie) {
        self.adult = movie.adult ?? false
        self.backdropPath = movie.backdropPath ?? ""
        self.id = movie.id ?? 0
        self.originalLanguage = movie.originalLanguage ?? ""
        self.originalTitle = movie.originalTitle ?? ""
        self.overview = movie.overview ?? ""
        self.popularity = movie.popularity ?? 0.0
        self.posterPath = movie.posterPath ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.title = movie.title ?? ""
        self.video = movie.video ?? false
        self.voteAverage = movie.voteAverage ?? 0.0
        self.voteCount = movie.voteCount ?? 0
    }
}

extension GenreObj: GenreProtocol {
    func setup(with genre: Genre) {
        self.id = genre.id
        self.name = genre.name
    }
}



class RealmCRUD {
    static func updateDatabase(dataType: MovieDataBase? = nil, response: DataType) {
        let realm = try! Realm()
        
        switch response {
        case .Movie(let result):
            result.results.forEach { movie in
                switch dataType! {
                case .favorite:
                    saveMovie(movie: movie, realm: realm, objectType: FavoriteMovieObj.self)
                    removeExtraMovie(response: result, realm: realm, objectType: FavoriteMovieObj.self)
                case .trend:
                    saveMovie(movie: movie, realm: realm, objectType: TrendMovieObj.self)
                    removeExtraMovie(response: result, realm: realm, objectType: TrendMovieObj.self)
                }
            }
        case .Genres(let result):
            result.genres.forEach { genre in
                saveGenre(genre: genre, realm: realm, objectType: GenreObj.self)
                removeExtraGenre(responce: result, realm: realm, objectType: GenreObj.self)
            }
        }
    }
    
    static func getMovie(dataType: MovieDataBase) -> [Movie] {
        var result: [Movie] = []
        let realm = try! Realm()
        
        switch dataType {
            
        case .favorite:
            let movies = realm.objects(FavoriteMovieObj.self)
            
            movies.forEach { movie in
                result.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIDS: [], id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount))
            }
            
        case .trend:
            let movies = realm.objects(TrendMovieObj.self)
            
            movies.forEach { movie in
                result.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIDS: [], id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount))
            }
        }
        
        return result
    }
    
    static func getGenre() -> [Genre] {
        var result: [Genre] = []
        var realm = try! Realm()
        
        let genres = realm.objects(GenreObj.self)
        
        genres.forEach { genre in
            result.append(Genre(id: genre.id, name: genre.name))
        }
        
        return result
    }
    
    private static func removeExtraMovie<T: Object>(response: MovieListResponce, realm: Realm, objectType: T.Type) where T: MovieProtocol {
        let savedMovies = realm.objects(objectType)
        
        savedMovies.forEach { savedMovie in
            if !response.results.contains(where: { $0.id == savedMovie.id }) {
                try! realm.write {
                    realm.delete(savedMovie)
                }
            }
        }
    }
    
    private static func removeExtraGenre<T: Object>(responce: GenresResponce, realm: Realm, objectType: T.Type) where T: GenreProtocol {
        let savedGenres = realm.objects(objectType)
        
        savedGenres.forEach { savedGenre in
            if !responce.genres.contains(where: { $0.id == savedGenre.id }) {
                try! realm.write {
                    realm.delete(savedGenre)
                }
            }
        }
    }
    
    
    private static func saveMovie<T: Object>(movie: Movie, realm: Realm, objectType: T.Type) where T: MovieProtocol {
        let savedMovies = realm.objects(objectType)
        
        if !savedMovies.contains(where: { $0.id == movie.id }) {
            let movieRealm = objectType.init()
            movieRealm.setup(with: movie)
            
            try! realm.write {
                realm.add(movieRealm)
            }
        }
    }
    
    private static func saveGenre<T: Object>(genre: Genre, realm: Realm, objectType: T.Type) where T: GenreProtocol {
        let savedGenres = realm.objects(objectType)
        
        if !savedGenres.contains(where: {$0.id == genre.id}) {
            let genreRealm = objectType.init()
            genreRealm.setup(with: genre)
            
            try! realm.write {
                realm.add(genreRealm)
            }
        }
    }
}
