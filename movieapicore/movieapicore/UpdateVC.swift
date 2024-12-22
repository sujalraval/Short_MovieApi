//
//  UpdateVC.swift
//  movieapicore
//
//  Created by Manthan Mittal on 22/12/2024.
//

import UIKit

class UpdateVC: UIViewController {
    @IBOutlet weak var textlable: UILabel!
    
    @IBOutlet weak var updimdb_url: UITextField!
    @IBOutlet weak var updimage: UITextField!
    @IBOutlet weak var updmovie: UITextField!
    
    @IBOutlet weak var updrating: UITextField!
    
    var moviePassed: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()

        // Do any additional setup after loading the view.
    }
    
    func showData() {
        
        updmovie.text = moviePassed.movie
        
        updrating.text = String(moviePassed.rating)
        
        updimage.text = moviePassed.image
        
        updimdb_url.text = moviePassed.imdb_url
        
        }
    
    @IBAction func updbtn(_ sender: Any) {
        
        let updateMovie = updmovie.text!
        let updatedRating = Double(updrating.text!)!
        let updatedImage = updimage.text!
        let updatedIMDB_URL = updimdb_url.text!
                
            
            //  CoreData's Update function called
            
            let updatedMovie = MovieModel(id: moviePassed.id, movie: updateMovie, rating: updatedRating, image: updatedImage, imdb_url: updatedIMDB_URL)
            
                DispatchQueue.main.async {
                            
                    CDManager().updateInCD(updateMovie: updatedMovie)
                    
                    self.navigationController?.popViewController(animated: true)
                            
                    print(updatedMovie)
                        }
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
