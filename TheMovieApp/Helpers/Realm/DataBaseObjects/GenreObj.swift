//
//  GenreObj.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 22.07.2024.
//

import Foundation
import RealmSwift

class GenreObj: Object {
    @Persisted var id: Int = 0
    @Persisted var name: String = ""
}
