//
//  DashboardViewController.swift
//  iosTest_scootsy
//
//  Created by vivek G on 12/04/20.
//  Copyright © 2020 vivek G. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController  {
    
    @IBOutlet weak var lvColViwHomeHeight: NSLayoutConstraint!
    
    //var viewPresenter = DashboardPresenter()
    var arrCategoriesList = [clsDashboardEntity]()
    var arrVenderList = [clsVenderDetailsEntity]()
    var arrBannerList = [clsDashboardEntity]()
    fileprivate var objPresenter = DashboardPresenter()

    @IBOutlet weak var colViwTopSlider: UICollectionView!
    @IBOutlet weak var colViwDashboard: UICollectionView!
    @IBOutlet weak var colViwBottomProduct: UICollectionView!
    @IBOutlet weak var lblBottomTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.setControllerPrefrances()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    //MARK: - User define method
    func setControllerPrefrances()
    {
        objPresenter.attachView(self, viw:self)
        objPresenter.getHomescreenData()
    }
}
class MyHeaderFooterClass: UICollectionReusableView {
}
extension DashboardViewController : GetDashboardDetails
{
    func showError(errorMessage: String)
    {
        self.view.makeToast(message: errorMessage)
    }
    func getHomescreenData(arrHomeData: [clsDashboardEntity], arrVenderData: [clsVenderDetailsEntity]) {
       
        self.arrVenderList = arrVenderData
        lblBottomTitle.text = self.arrVenderList.count > 0 ? "- More From \(self.arrVenderList[0].name) -" : ""
        
        self.colViwTopSlider.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.arrCategoriesList = arrHomeData
            
            var fixRow = Double(self.arrCategoriesList.count) / Double(3.0)
            fixRow = fixRow.rounded(.awayFromZero)
            let cellHeight = ((self.view.frame.width / 3) - 5)
            self.lvColViwHomeHeight.constant = CGFloat(fixRow) * cellHeight
            self.colViwDashboard.reloadData()
            
            self.objPresenter.getBottomScreenData()
        }
    }
    func getFooterBannerData(arrBannerData: [clsDashboardEntity])
    {
        self.arrBannerList = arrBannerData
        self.colViwBottomProduct.reloadData()
    }
}

extension DashboardViewController : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colViwTopSlider
        {
            return arrVenderList.count
        }
        else
            if collectionView == colViwDashboard
            {
                return arrCategoriesList.count
        }
        else
                if collectionView == colViwBottomProduct
            {
                return arrBannerList.count
        }
        return 0
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == colViwTopSlider
        {
            let cell = colViwTopSlider.dequeueReusableCell(withReuseIdentifier: "cellTopBanner", for: indexPath) as! clsDashboardCollectionViewCell
            let ent = arrVenderList[indexPath.row]
            cell.imgLogo.sd_setImage(with: URL(string: ent.app_image))
            return cell
        }
        else
            if collectionView == colViwDashboard
            {
                let cell = colViwDashboard.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! clsDashboardCollectionViewCell
                let ent = arrCategoriesList[indexPath.row]
                cell.imgLogo.sd_setImage(with: URL(string: ent.image))
                cell.lblTitle.text = ent.name
                cell.imgLogo.contentMode = .scaleAspectFit
                return cell
            }
            else // if collectionView == colViwBottomProduct
                {
                    let cell = colViwBottomProduct.dequeueReusableCell(withReuseIdentifier: "cellBottomBanner", for: indexPath) as! clsDashboardCollectionViewCell
                    let ent = arrBannerList[indexPath.row]
                    cell.imgLogo.sd_setImage(with: URL(string: ent.image))
                    cell.viwBG.layer.cornerRadius = 20
                    cell.viwBG.layer.masksToBounds = true
                    return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colViwTopSlider
        {
            return CGSize(width: collectionView.frame.width
                , height: 200)
        }
        else
            if collectionView == colViwDashboard
            {
                return CGSize(width: (self.view.frame.width / 3 ) - 5
                    , height: (self.view.frame.width / 3 ) - 5)
            }
            else
                if collectionView == colViwBottomProduct
                {
                    return CGSize(width: collectionView.frame.width
                        , height: 200)
        }
        return CGSize(width: 0, height: 0)
    }
}
class clsDashboardCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viwBG: UIView!
}
