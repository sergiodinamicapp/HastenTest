//
//  Spinner.swift
//  
//
//  Created by sergio blanco martin on 03/12/2019.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.center = aView!.center
        spinner.startAnimating()
        aView?.addSubview(spinner)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
