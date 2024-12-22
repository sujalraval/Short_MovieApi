//
//  FormVC.swift
//  movieapicore
//
//  Created by Manthan Mittal on 22/12/2024.
//

import UIKit

class FormVC: UIViewController {

    @IBOutlet weak var textlable: UILabel!
    
    @IBOutlet weak var textmovie: UITextField!
    @IBOutlet weak var textrating: UITextField!
    
    @IBOutlet weak var textimdb_url: UITextField!
    @IBOutlet weak var textimage: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

     @IBAction func submitbtn(_ sender: Any) {
         
         let id = Int.random(in: 0...1000)
         let movie = textmovie.text!
         let rating = Double(textrating.text!)!
         let image = textimage.text!
         let imdb_url = textimdb_url.text!
                 
             let mmovie = MovieModel(id: Int(id), movie: movie, rating: rating, image: image, imdb_url: imdb_url)
                         DispatchQueue.main.async {
                             CDManager().AddToCd(movieToAdd: mmovie)
                             self.navigationController?.popViewController(animated: true)
                         }
                         

     }

}
