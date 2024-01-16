//
//  UIViewController+Extention.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 17.01.2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlert(title: String? = nil, message: String, handler:(() -> Void)? = nil, actionTitle: String? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: actionTitle ?? "Close",
                                          style: .cancel) { action in
            guard handler != nil else { return }
            handler!()
        }
        
        alert.addAction(dismissAction)
        self.present(alert, animated: true)
    
    }
}
