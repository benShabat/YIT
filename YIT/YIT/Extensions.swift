//
//  Extensions.swift
//  YIT
//
//  Created by Ben Shabat on 18/08/2021.
//

import Foundation
import UIKit

extension UIView{
    func addLoadingIndicator(){
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.style = .large
        view.startAnimating()
        view.center = self.center
        self.addSubview(view)
    }
    func removeLoadingIndicator(){
        for view in subviews{
            if view.isKind(of: UIActivityIndicatorView.self) {
                view.removeFromSuperview()
            }
        }
    }
}

extension UIImageView {
    func loadImageWithUrlString(urlString: String) {
        if let url = URL(string: urlString){
            let request = URLRequest(url: url)
            image = nil
            let task = URLSession.shared.dataTask(
                with: request,
                completionHandler: { data, response, error in
                    DispatchQueue.main.async(execute: {
                        if error != nil{
                            print(error?.localizedDescription ?? "Eror Downloading image")
                            return
                        }
                        if let data = data{
                            self.image = UIImage(data: data)
                        }
                        
                    })
                })
            task.resume()
        }
    }
}

