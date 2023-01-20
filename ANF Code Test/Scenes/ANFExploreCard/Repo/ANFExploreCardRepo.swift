//
//  ANFExploreCardRepo.swift
//  ANF Code Test
//
//  Created by Elle Kadfur on 1/18/23.
//

import Foundation

//MARK: ANFExploreCardRepo
class ANFExploreCardRepo {
    
    /// getProductListJsonApiCall
    func getProductListJson(jsonUrl:String, completion :@escaping(_ status : Bool, _ errorMsg:String, _ resultData:[ProductData]?) ->()) {
        let Url = String(format: jsonUrl)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        let decodeJson = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                        let productData =  try JSONDecoder().decode([ProductData].self, from: decodeJson)
                        completion(true, error?.localizedDescription ?? "", productData)
                    } catch(let error) {
                        completion(false, error.localizedDescription, nil)
                        print(error)
                    }
                }
            } else {
                completion(false, error?.localizedDescription ?? "", nil)
            }
        }.resume()
    }
    
}
