//
//  ErrorMessages.swift
//  PexelsAPISearch
//
//  Created by Anthony Torres on 6/13/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import UIKit


struct ErrorMessageStruct {
    var currentView: UIViewController = UIViewController()
    
    enum ErrorType {
        case error, warning
        
        var title: String {
            switch self {
            case .error:
                return "Error"
            case .warning:
                return "Warning"
            }
        }
    }
    
    mutating func showError(with message: String, errorType: ErrorType) {
        let alert = UIAlertController(title: errorType.title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        currentView.present(alert, animated: true, completion: nil)
    }
}
