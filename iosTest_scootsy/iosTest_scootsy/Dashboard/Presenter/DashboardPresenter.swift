//
//  DashboardPresenter.swift
//  iosTest_scootsy
//
//  Created by vivek G on 12/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import UIKit

class DashboardPresenter: NSObject {
    var parentView : UIViewController?
    //MARK: - Variable Declaration
    fileprivate var dashboardView : GetDashboardDetails?
    
    var arrCategories = [clsDashboardEntity]()
    var arrVenderDetals = [clsVenderDetailsEntity]()
    
    /// Function to attach the view
    ///
    /// - Parameter view: GetUserDetails class object
    func attachView(_ view: GetDashboardDetails, viw:DashboardViewController) {
        dashboardView = view
        parentView = viw
    }
    
    /// Function to release the view
    func detachView() {
        dashboardView = nil
    }
    
    
    //MARK: - Api call //
    func getHomescreenData()
    {
        if Utility.shared.isConnectedToNetwork() == false
        {
                Utility.shared.showAlert(strMsg : Constants.NoInternet ,onView:self.parentView!)
            return
        }
        let objRequest = RequestManager()
        let strUrl = URLConstants.CommonURL + URLConstants.homeUrl
        
        let dictMyContact = [String:Any]()
        Utility.shared.showLoader()
        objRequest.requestCommonApiMethodCall_WithParam(strAPIName: strUrl, strMethodType: "GET", strParameterName: dictMyContact)
        { (result, isSuccess, error) in
            //Utility.shared.hideLoader()
            DispatchQueue.main.async {
                if isSuccess{
                            if let main_content = result["main_content"] as? [String :Any]
                            {
                                if let data = main_content["data"] as? [Any]
                                {
                                    for obj in data {
                                        
                                        let objData = obj as? [String:Any]
                                        if let arrCat = objData?["category"] as? [[String:Any]]
                                        {
                                            for item in arrCat
                                            {
                                                let entHome = clsDashboardEntity(json: item )
                                                self.arrCategories.append(entHome)
                                            }
                                        }
                                        if let arrVender = objData?["vendor_type_details"] as? [[String:Any]]
                                        {
                                            for item in arrVender
                                            {
                                                let entHome = clsVenderDetailsEntity(json: item )
                                                self.arrVenderDetals.append(entHome)
                                            }
                                        }
                                    }
                                }
                            }
                    
                    self.dashboardView?.getHomescreenData(arrHomeData: self.arrCategories, arrVenderData: self.arrVenderDetals)
                }
                else
                {
                    Utility.shared.hideLoader()
                    Utility.shared.showAlert(strMsg : error,onView:self.parentView!)

                }
            }
        }
    }
    func getBottomScreenData()
    {
        if Utility.shared.isConnectedToNetwork() == false
        {
            Utility.shared.showAlert(strMsg : Constants.NoInternet ,onView:self.parentView!)
            return
        }
        let objRequest = RequestManager()
        let strUrl = URLConstants.CommonURL + URLConstants.bannerUrl
        
        let dictMyContact = [String:Any]()
        
        //Utility.shared.showLoader()
        objRequest.requestCommonApiMethodCall_WithParam(strAPIName: strUrl, strMethodType: "GET", strParameterName: dictMyContact)
        { (result, isSuccess, error) in
            Utility.shared.hideLoader()
//            self.dashboardView?.removeSpinner()
            DispatchQueue.main.async {
                if isSuccess{
                    if let main_content = result["main_content"] as? [String :Any]
                    {
                        if let item = main_content["item"] as? [String :Any]
                        {
                            if let data = item["data"] as? [Any]
                            {
                                self.arrCategories.removeAll()
                                for obj in data {
                                    let entHome = clsDashboardEntity(json: obj as! [String : Any] )
                                    self.arrCategories.append(entHome)
                                }
                            }
                        }
                    }
                    
                    self.dashboardView?.getFooterBannerData(arrBannerData: self.arrCategories)
                }
                else
                {
                    Utility.shared.showAlert(strMsg : error,onView:self.parentView!)
                }
            }
        }
    }
}


