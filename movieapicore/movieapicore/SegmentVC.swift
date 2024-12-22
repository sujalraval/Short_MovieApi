//
//  SegmentVC.swift
//  movieapicore
//
//  Created by Manthan Mittal on 22/12/2024.
//

import UIKit

class SegmentVC: UIViewController {

    @IBOutlet weak var tablesegment: UISegmentedControl!
    
    @IBOutlet weak var apitbl: UITableView!
    
    @IBOutlet weak var coredatatbl: UITableView!
    
    var selectedMovie: MovieModel!
    var apiArr: [MovieModel] = []
    var coredataArr: [MovieModel] = []
    
    //View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.coredataArr = CDManager().readFromCd()
        
        ApiCall()
        reloadUI()
        
    }
    
    //View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tablesegment.selectedSegmentIndex = 0
        self.coredataArr = CDManager().readFromCd()
        setup()
        reloadUI()

    }
    
    // reload func of table1
    func reloadTbl1()  {
        
        DispatchQueue.main.async {
            
            self.apitbl.reloadData()
        }
    }
    
    // reload func of table2
    func reloadTbl2()  {
        
        DispatchQueue.main.async {
            
            self.coredatatbl.reloadData()
        }
    }
    
    // Update Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToUpdate" {
            
            if let updateVC = segue.destination as? UpdateVC {
                
                updateVC.moviePassed = selectedMovie
            }
        }
    }
    
    // API call func
    func ApiCall(){
        ApiManager().fetchMovie{ result in
            switch result {
            case.success(let data):
                self.apiArr.append(contentsOf: data)
                print(self.apiArr)
                self.reloadTbl1()
                
            case.failure(let error):
                print("err: \(error)")
            }
        }
    }
    
    //Api and Coredata
    
    func reloadUI() {
            
        if self.tablesegment.selectedSegmentIndex == 0 {
                self.ApiCall()
                self.reloadTbl1()
                self.apitbl.isHidden = false
                self.coredatatbl.isHidden = true

                
        } else if self.tablesegment.selectedSegmentIndex == 1 {
                
                self.coredataArr = CDManager().readFromCd()
                
                self.reloadTbl2()
                
                self.apitbl.isHidden = true
                
                self.coredatatbl.isHidden = false
                
            }
    }
    
    //delete Func
    func deleteFromArr(position: Int) {
        
        coredataArr.remove(at: position)
        
        DispatchQueue.main.async {
            
            self.coredatatbl.reloadData()
        }
    }
 
    @IBAction func segmentchanged(_ sender: Any) {
        print("current selected segment: \(tablesegment.selectedSegmentIndex)")
        
        reloadUI()
    }
    
}


extension SegmentVC: UITableViewDelegate, UITableViewDataSource {

    
    func setup() {
        
        apitbl.delegate = self
        coredatatbl.delegate = self
        
        apitbl.dataSource = self
        coredatatbl.dataSource = self
        
        apitbl.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        coredatatbl.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        apitbl.isHidden = false
        coredatatbl.isHidden = true
        
        reloadUI()
    }
    
    // for table row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablesegment.selectedSegmentIndex == 0 ? apiArr.count : coredataArr.count
    }
    
    // for table cell row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            
                        return UITableViewCell()
                }
        
        let currSeg = tablesegment.selectedSegmentIndex
                
        switch currSeg {
            
        case 0:
            guard indexPath.row < apiArr.count else {
                
                print("Index out of bounds for apiArr")
                
                return cell
            }
            
            let movie = apiArr[indexPath.row]
            configureCell(cell, with: movie)
                    
        case 1:
            guard indexPath.row < coredataArr.count else {
                
                print("Index out of bounds for coredataArr")
                
                return cell
            }
                    
            let movie = coredataArr[indexPath.row]
            configureCell(cell, with: movie)
                    
        default:
            break
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    private func configureCell(_ cell: MovieCell, with movie: MovieModel) {
        // outlet which is created in movie cell lid, lmovie etc...
        cell.lid.text = "\(movie.id)"
        
        cell.lmovie.text = movie.movie
        
        cell.lrating.text = String(movie.rating)
        
        cell.limage.text = movie.image
        
        cell.limdb_url.text = movie.imdb_url

        }
    
    //selected joke stor in coredata table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        if tableView == apitbl {
                
            let movieSelected = apiArr[indexPath.row]
            CDManager().AddToCd(movieToAdd: movieSelected)
            apitbl.deselectRow(at: indexPath, animated: true)
            print(movieSelected)
        } else if tableView == coredatatbl {
            coredatatbl.deselectRow(at: indexPath, animated: true)

            }
        }
    
    //swipe Update Func
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == coredatatbl {
                
                let updateAction = UIContextualAction(style: .normal, title: "Update") { (action, view, completionHandler) in
                
                    self.selectedMovie = self.coredataArr[indexPath.row]
                    self.performSegue(withIdentifier: "GoToUpdate", sender: self)
                    
                    completionHandler(true)
                }
                updateAction.backgroundColor = .systemOrange
                updateAction.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
                let updateConfig = UISwipeActionsConfiguration(actions: [updateAction])
                
                return updateConfig
            
        } else {
            let updateConfig = UISwipeActionsConfiguration(actions: [])
            return updateConfig
        }
    }
    
    //swipe Delete func
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if tableView == coredatatbl {
            
                let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [self] action, source, completion in
                        //  CoreData's Delete function called
                    
                let movieToDelete = coredataArr[indexPath.row]
                    
                    CDManager().deleteFromCD(movies: movieToDelete)
                    
                    coredataArr.remove(at: indexPath.row)
                    
                    reloadTbl2()
                    
                };
            deleteAction.backgroundColor = .systemRed
            deleteAction.image = UIImage(systemName: "minus.circle.fill")
            
            let deleteConfig = UISwipeActionsConfiguration(actions: [deleteAction])
            
            deleteConfig.performsFirstActionWithFullSwipe=false
            
                return deleteConfig
            } else {
                let deleteConfig = UISwipeActionsConfiguration(actions: [])
                
                deleteConfig.performsFirstActionWithFullSwipe = false
                
                return deleteConfig
            }
        
    }
    
    
}
