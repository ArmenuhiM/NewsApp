//
//  ApiClientService.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/1/21.
//



class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class ApiClientService {
        
    class func getRequest<T : Codable>(_ strURL: String, success: @escaping (Base<T>) -> Void, failure: @escaping (String, Int) -> Void) {
        
        if !Connectivity.isConnectedToInternet() {
            failure(NSLocalizedString(Constants.NoConnection, comment: ""), 0)
            return
        }
        
        Loading.sharedInstance.showActivityIndicator()
        let url = strURL
        let urlwithPercentEscapes = url.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        var request = URLRequest(url: URL(string: urlwithPercentEscapes!)!)
        request.timeoutInterval = 180
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(request).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                Loading.sharedInstance.hideActivityIndicator()
                if response.result.isSuccess {
                    if response.response?.statusCode == 200 {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted)
                            let reqJSONStr = String(data: jsonData, encoding: .utf8)
                            
                            let data = reqJSONStr?.data(using: .utf8)
                            let jsonDecoder = JSONDecoder()
                            let responseData = try jsonDecoder.decode((Base<T>).self, from: data!)
                            success(responseData)
                        } catch {
                            print(error)
                        }
                    }
                }
            case .failure:
                Loading.sharedInstance.hideActivityIndicator()
            }
        }
    }
}
