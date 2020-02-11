//
//  FilmGridViewController.swift
//  myFlix
//
//  Created by Andre Vincent on 2/10/20.
//  Copyright © 2020 Andre Vincent. All rights reserved.
//

import UIKit
import AlamofireImage

class FilmGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var filmes = [[String: Any]]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmGridCell", for: indexPath) as! FilmGridCell
        let film = filmes[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = film["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval:  10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: [] ) as! [String: Any]
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                self.filmes = dataDictionary["results"] as! [[String:Any]]
                
                self.collectionView.reloadData()
                print(self.filmes)
                //print(dataDictionary)
            }
            
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
