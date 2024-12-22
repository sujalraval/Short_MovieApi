//
//  MovieCell.swift
//  movieapicore
//
//  Created by Manthan Mittal on 22/12/2024.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var lid: UILabel!
    
    @IBOutlet weak var lmovie: UILabel!
    
    @IBOutlet weak var limage: UILabel!
    
    @IBOutlet weak var lrating: UILabel!
    
    @IBOutlet weak var limdb_url: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
