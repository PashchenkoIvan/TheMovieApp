//
//  ViewController.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 17.07.2024.
//

import UIKit

class GeneralViewController: UIViewController {

    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    
    var generalLogic: GeneralViewControllerViewModel = GeneralViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Genres"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        generalLogic.updateTrendingMovieArray {
            self.trendingCollectionView.reloadData()
        }
        
        generalLogic.updateGenresArray {
            self.genresCollectionView.reloadData()
        }
        
    }


}

