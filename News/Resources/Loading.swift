//
//  Loading.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//

final class Loading: NSObject {
    
    static let sharedInstance = Loading()
    var activityIndicator:UIActivityIndicatorView?
    
    func getActivityIndicatorView() -> UIActivityIndicatorView? {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
            activityIndicator?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            activityIndicator?.hidesWhenStopped = true
            DispatchQueue.main.async {
                self.activityIndicator?.frame = (UIApplication.shared.keyWindow?.frame)!
                UIApplication.shared.keyWindow?.addSubview(self.activityIndicator!)
            }
        }
        UIApplication.shared.keyWindow?.bringSubviewToFront(activityIndicator!)
        return activityIndicator
    }
    
    func showActivityIndicator() {
        getActivityIndicatorView()?.startAnimating()
    }
    
    func hideActivityIndicator() {
        getActivityIndicatorView()?.stopAnimating()
    }
}
