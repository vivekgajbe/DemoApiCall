//
//  BaseView.swift
//  iosTest_scootsy
//
//  Created by vivek G on 16/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import Foundation

/// This is a base protocol which contains commom methods present in the mvp views
@objc protocol MBBaseView {
//    func showLoader()
//    func hideLoader()
    func showError(errorMessage: String)
}
