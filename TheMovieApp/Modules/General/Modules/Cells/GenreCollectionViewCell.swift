//
//  GenreCollectionViewCell.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 19.07.2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 10 // Установите нужное значение радиуса
        self.clipsToBounds = true
//        self.layer.borderWidth = 1.0 // Установите ширину бордера
//        self.layer.borderColor = UIColor.systemPink.cgColor // Установите цвет бордера
    }
    
    @IBOutlet weak var genresTextLabel: UILabel!
}
