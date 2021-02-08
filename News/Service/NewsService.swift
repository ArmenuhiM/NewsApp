//
//  NewsService.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//


class NewsService {
    
    func news(url: String, success: @escaping (_ response: [NewsResponse] ) -> Void, failer: @escaping (String,  Int) -> Void) {
        
        ApiClientService.getRequest(url, success: { (response: Base<[NewsResponse]>) in
            if response.success {
                if let data = response.metadata {
                    success(data)
                }
            }
        }) { (errorMsg: String, errorValue: Int) in
            failer(errorMsg, errorValue)
        }
    }
}
