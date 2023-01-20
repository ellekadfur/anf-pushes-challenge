//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//
//  Created by Elle Kadfur on 1/18/23.
//

import UIKit
import SDWebImage

class ANFExploreCardTableViewController: UITableViewController {
    
    var productList = [ProductData]()
    lazy var viewModel : ANFExploreCardViewModel = {
        return ANFExploreCardViewModel {  message in
            DispatchQueue.main.async {
                self.showSimpleAlert(Message: message)
            }
        }
    }()
    
    //MARK: getProductList
    func getProductList() {
        viewModel.PeoductList.observe { [weak self] items in
            guard let `self` = self else { return }
            if items.isEmpty {
                self.tableView.setEmptyMessage("No Data Found!", font: nil, textColor: nil)
            } else {
                self.productList = items
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductList()
        self.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    @objc func reloadData() {
        self.refreshControl?.beginRefreshing()
        viewModel.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productList.count != 0 {
            return productList.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "exploreContentCell") as? exploreContentCell else {return UITableViewCell()}
        
        cell.lblTitle.text = productList[indexPath.row].title ?? ""
        let bgImage = productList[indexPath.row].backgroundImage ?? ""
        cell.ivBackground.sd_setImage(with: URL(string: bgImage), completed: nil)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = UIStoryboard(name: "ExploreCardDetails", bundle: nil).instantiateViewController(withIdentifier: "ANFExploreCardDetailsViewController") as? ANFExploreCardDetailsViewController
         vc?.productDetail = productList[indexPath.row]
         self.navigationController?.pushViewController(vc!, animated: true)
     }
    
}

//MARK: exploreContentCell Class
class exploreContentCell: UITableViewCell {
     @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivBackground: UIImageView!
}
