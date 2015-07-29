//
//  FlickrPhotosViewControllerCollectionViewController.swift
//  FlickerSearcher
//
//  Created by Mr Burns on 7/29/15.
//  Copyright (c) 2015 Jeffrey Leonard. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class FlickrPhotosViewControllerCollectionViewController: UICollectionViewController {

    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    private var searches = [FlickrSearchResults]()
    private let flickr = Flickr()
    
    func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
    
    }
    extension FlickrPhotosViewControllerCollectionViewController : UITextFieldDelegate {
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            // 1
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            textField.addSubview(activityIndicator)
            activityIndicator.frame = textField.bounds
            activityIndicator.startAnimating()
            flickr.searchFlickrForTerm(textField.text) {
                results, error in
                
                //2
                activityIndicator.removeFromSuperview()
                if error != nil {
                    println("Error searching : \(error)")
                }
                
                if results != nil {
                    //3
                    println("Found \(results!.searchResults.count) matching \(results!.searchTerm)")
                    self.searches.insert(results!, atIndex: 0)
                    
                    //4
                    self.collectionView?.reloadData()
                }
            }
            
            textField.text = nil
            textField.resignFirstResponder()
            return true
        }
    }

