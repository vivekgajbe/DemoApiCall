//
//  BaseViewController.swift
//  iosTest_scootsy
//
//  Created by vivek G on 12/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class BaseViewController: UIViewController {

    var vSpinner : UIView?
    let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - loader method
    func showSpinner(onView : UIView) {
        
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    //remove loader from view
    func removeSpinner() {
        
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    //---------------------------------------------------------------------------
    // function to Show loader
    //---------------------------------------------------------------------------
    func showLoader()
    {
        let spinnerView = UIView.init(frame: (Constants.APP_DEL.window?.bounds)!)
        spinnerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            Constants.APP_DEL.window?.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    //---------------------------------------------------------------------------
    // function to hide loader
    //---------------------------------------------------------------------------
    func hideLoader()
    {
        Constants.iLoaderCount = Constants.iLoaderCount - 1
        
        if Constants.iLoaderCount > 0
        {
            return
        }
        
        Constants.iLoaderCount = 0
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
//        Constants.APP_DEL.window?.hideRMLoader()
    }
}
