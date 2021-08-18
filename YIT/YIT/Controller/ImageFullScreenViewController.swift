//
//  ImageFullScreenViewController.swift
//  YIT
//
//  Created by Ben Shabat on 18/08/2021.
//

import UIKit

class ImageFullScreenViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: SearchViewModel!
    var indexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.2) {
            if let index = self.indexPath{
                self.collectionView.scrollToItem(at: index, at: .left, animated: false)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.arrImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! FullScreenImageCollectionViewCell
            cell.image.loadImageWithUrlString(urlString: model.arrImages[indexPath.row].largeImageURL)
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
}
