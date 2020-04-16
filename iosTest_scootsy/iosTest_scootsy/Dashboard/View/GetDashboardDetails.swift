//
//  GetDashboardDetails.swift
//  iosTest_scootsy
//
//  Created by vivek G on 14/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import Foundation

protocol GetDashboardDetails : MBBaseView
{
    func getHomescreenData(arrHomeData: [clsDashboardEntity],arrVenderData:[clsVenderDetailsEntity])
    func getFooterBannerData(arrBannerData: [clsDashboardEntity])
//    func getHomeBottomScreenData(objBottomData: clsDashboardEntity)
}
