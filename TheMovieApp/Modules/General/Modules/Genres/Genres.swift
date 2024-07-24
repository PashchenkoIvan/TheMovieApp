//
//  Genres.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 22.07.2024.

import Foundation

// MARK: - GenresResponce
struct GenresResponce: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
