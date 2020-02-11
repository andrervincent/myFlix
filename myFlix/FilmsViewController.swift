//
//  FilmsViewController.swift
//  myFlix
//
//  Created by Andre Vincent on 1/21/20.
//  Copyright © 2020 Andre Vincent. All rights reserved.
//

import UIKit
import AlamofireImage

class FilmsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var filmes = [[String: Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // handing off duties
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                self.tableView.reloadData()
                print(dataDictionary)
            }
            
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "FilmViewCell") as! FilmViewCell
        
        let film = filmes[indexPath.row]
        let title = film["title"] as! String
        let synopsis = film["overview"] as! String
        
        cell.titleLabel?.text = title
        cell.synopsisLabel?.text = synopsis
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = film["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        cell.filmImage.af_setImage(withURL: posterUrl!)
        return cell
    }
    
    
    
    
    
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading details screen")
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let film = filmes[indexPath.row]
        
        let detailsViewController = segue.destination as! FilmDetailViewController
        detailsViewController.film = film
    }
 

}
