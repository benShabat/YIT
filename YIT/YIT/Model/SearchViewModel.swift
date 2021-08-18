//
//  SearchViewModel.swift
//  YIT
//
//  Created by Ben Shabat on 18/08/2021.
//

import Foundation

class SearchViewModel {

    let userDefaults = UserDefaults.standard
    var query = ""
    var pageNumber = 1
    var arrImages = [ImageEntity]()
    var isWaiting = false
    
     func fetchImages(completion: @escaping () -> Void){
        NetworkManager.sharedInstance.fetchData(query: query, page: String(self.pageNumber)) { arrImages in
                self.arrImages = arrImages.hits
                completion()
        }
    }
      func doPaging(completion: @escaping () -> Void) {
        // call the API in this block and after getting the response
        NetworkManager.sharedInstance.fetchData(query: query, page: String(self.pageNumber)) { arrImages in
            DispatchQueue.main.async {
                for image in arrImages.hits{
                    self.arrImages.append(image)
                }
                self.isWaiting = false
                completion()
            }
        }
    }
}
