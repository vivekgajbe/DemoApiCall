//
//  BasePresenter.swift
//  iosTest_scootsy
//
//  Created by vivek G on 16/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import UIKit

class BasePresenter: NSObject {
    /// Function to check for the error is present or not
    ///
    /// - Parameter error: error string
    /// - Returns: error string
    func parseError(error: String) -> String
    {
        if error.count > 0
        {
            return error
        }
        else
        {
            return Constants.apologiesMessage
        }
    }
}
