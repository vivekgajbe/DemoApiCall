//
//  Constants.swift
//  iosTest_scootsy
//
//  Created by vivek G on 12/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import UIKit

class Constants: NSObject
{
    //MARK: -
    static var iLoaderCount = 0
    
    //MARK:- var declaration
    static let APP_DEL : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let uiScreen: UIScreen = UIScreen.main
    
    
    //MARK: - Alert statement
    static let apologiesMessage = "We apologize this service is temporarily unavailable.Please try later."
    static let NoInternet = "Internet connection not available"
}
