//
//  ViewController.swift
//  YIT
//
//  Created by Ben Shabat on 18/08/2021.
//

import UIKit

class SearchViewController: UIViewController,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldSearch.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        txtFieldSearch.layer.cornerRadius = 8
        
        if let query = searchViewModel.userDefaults.string(forKey: "query") {
            self.txtFieldSearch.text = query.replacingOccurrences(of: "+", with: " ")
            searchViewModel.query = query
            fetchImages()
        }
    }
    func fetchImages(){
        self.view.addLoadingIndicator()
        searchViewModel.fetchImages(completion: {
            DispatchQueue.main.async {
                self.view.removeLoadingIndicator()
                self.collectionView.reloadData()
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! ImageCollectionViewCell
        cell.image.loadImageWithUrlString(urlString: searchViewModel.arrImages[indexPath.row].previewURL)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.arrImages.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = searchViewModel.arrImages[indexPath.row]
        
        return CGSize(width: image.previewWidth, height: image.previewHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ImageFullScreenViewController") as! ImageFullScreenViewController
        vc.indexPath = indexPath
        vc.model = self.searchViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == searchViewModel.arrImages.count - 2 && !searchViewModel.isWaiting {
            searchViewModel.isWaiting = true
            searchViewModel.pageNumber += 1
            self.view.addLoadingIndicator()
            searchViewModel.doPaging(completion: {
                self.collectionView.reloadData()
                self.view.removeLoadingIndicator()
            })
        }
    }
  
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 > 0 {
            if let query = textField.text?.replacingOccurrences(of: " ", with: "+"){
                searchViewModel.query = query
                searchViewModel.userDefaults.set(query, forKey: "query")
               fetchImages()
                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            textField.resignFirstResponder()
            return true
        }
        
        
        return false
    }
    
    
}

