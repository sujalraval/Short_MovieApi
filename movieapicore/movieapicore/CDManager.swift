//
//  CDManager.swift
//  movieapicore
//
//  Created by Manthan Mittal on 22/12/2024.
//

import UIKit
import CoreData


class CDManager {
    
    //read func for CD
    
    func readFromCd() -> [MovieModel] {
        
        var coredataArr: [MovieModel] = []
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = delegate!.persistentContainer.viewContext
                
                let fetchRes = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
                
        do {
            
            let dataArr = try managedContext.fetch(fetchRes)
            
            for data in dataArr as! [NSManagedObject] {
                
                let mID = data.value(forKey: "id") as! Int
                
                let mMovie = data.value(forKey: "movie") as! String
                
                let mRating = data.value(forKey: "rating") as! Double
                
                let mImage = data.value(forKey: "image") as! String
                
                let mIMDB_url = data.value(forKey: "imdb_url") as! String
                
                coredataArr.append(MovieModel(id: mID, movie: mMovie, rating: mRating, image: mImage, imdb_url: mIMDB_url))
                
                print("type: \(mMovie)")

            }
            
        } catch let err as NSError {
            print(err)
        }
        return coredataArr
    }
    
    //add func for CD
    
    func AddToCd(movieToAdd: MovieModel) {
        
        guard let delegate = UIApplication.shared.delegate as?AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        guard let movieEnt = NSEntityDescription.entity(forEntityName: "Movies", in: managedContext) else { return }
        
        let movie = NSManagedObject(entity: movieEnt, insertInto: managedContext)
        
        movie.setValue(movieToAdd.id, forKey: "id")
        
        movie.setValue(movieToAdd.movie, forKey: "movie")
        
        movie.setValue(movieToAdd.rating, forKey: "rating")
        
        movie.setValue(movieToAdd.image, forKey: "image")
        
        movie.setValue(movieToAdd.imdb_url, forKey: "imdb_url")
        
        do {
            
            try managedContext.save()
            print("Movie is saved successfully!")
            
        }catch let err as NSError {
            print(err)
        }
    }
    
    //delete func for CD
    
    func deleteFromCD(movies: MovieModel) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
                
        let managedContext = delegate.persistentContainer.viewContext
                
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
                
        fetchRequest.predicate = NSPredicate(format: "id = %d", movies.id)
        
            do {
                
                let fetchRes = try managedContext.fetch(fetchRequest)
                
                let objToDelete = fetchRes[0] as! NSManagedObject
                managedContext.delete(objToDelete)
                
                try managedContext.save()
                print("Movie deleted successfully")
                
            } catch let err as NSError {
                
                print("Somthing went wrong while deleting \(err)")
                
            }
        }
    
    //update func for CD
    
    func updateInCD(updateMovie: MovieModel) {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        
        fetchRequest.predicate = NSPredicate(format: "id = %data", updateMovie.id)
        
        do {
            
            let rawData = try managedContext.fetch(fetchRequest)
            
            let objUpdate = rawData[0] as! NSManagedObject
            
            objUpdate.setValue(updateMovie.movie, forKey: "movie")
            
            objUpdate.setValue(updateMovie.rating, forKey: "rating")
            
            objUpdate.setValue(updateMovie.image, forKey: "image")
            
            objUpdate.setValue(updateMovie.imdb_url, forKey: "imdb_url")
            
            try managedContext.save()
            
            print("Data updated Successfully")
            
        }catch let err as NSError {
            
            print("Somthing went wrong while deleting \(err)")
            
        }
        
        
    }
    
}
