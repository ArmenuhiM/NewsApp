//
//  VideoViewController.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/6/21.
//


class VideoViewController: UIViewController {
    
    @IBOutlet var webPlayerView: UIView!
    
    var webPlayer: WKWebView!
    var videoId: String? = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        DispatchQueue.main.async {
            
            self.webPlayer = WKWebView(frame: self.webPlayerView.bounds, configuration: webConfiguration)
            self.webPlayerView.addSubview(self.webPlayer)
            self.webPlayer.navigationDelegate = self
            
            guard let videoURL = URL(string: Constants.YoutubeBaseUrl + (self.videoId ?? "")) else { return }
            let request = URLRequest(url: videoURL)
            self.webPlayer.load(request)
        }
    }
}

extension VideoViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Loading.sharedInstance.showActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loading.sharedInstance.hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Loading.sharedInstance.hideActivityIndicator()
    }
}
