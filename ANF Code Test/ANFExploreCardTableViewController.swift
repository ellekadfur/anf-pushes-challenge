//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import SDWebImage

class ANFExploreCardTableViewController: UITableViewController {
    
    var productList = [ProductData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductListJson()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productList.count != 0 {
            return productList.count
        } else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "exploreContentCell",
                                                      for: indexPath) as? exploreContentCell
        
        cell?.lblTitle.text = productList[indexPath.row].title ?? ""
        
        let bgImage = productList[indexPath.row].backgroundImage ?? ""
        
        cell?.ivBackground.sd_setImage(with: URL(string: bgImage), completed: nil)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ANFExploreCardDetailsViewController") as? ANFExploreCardDetailsViewController
        vc?.productDetail = productList[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}

//MARK: exploreContentCell Class
class exploreContentCell : UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivBackground: UIImageView!
}

//MARK: Api Calling
extension ANFExploreCardTableViewController {
    
    func getProductListJson() {
        let Url = String(format: "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let decodeJson = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    self.productList = try JSONDecoder().decode([ProductData].self, from: decodeJson)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
