//
//  NewsViewController.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//


protocol NewsSelectionDelegate: class {
    func newsSelected(_ newNews: NewsResponse)
}

class NewsViewController: UITableViewController {
    
    var bookmars = [Int]()
    var newsResponse: [NewsResponse]?
    weak var delegate: NewsSelectionDelegate?
    var userDefaults = UserDefaults.standard

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleForegroundNotification(notification:)),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    @objc func handleForegroundNotification(notification: Notification) {
        tableView.backgroundColor = .random()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         news()
    }
    

    
    private func configureUI() {
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            let detailViewController = (controllers[controllers.count-1] as? UINavigationController)?.topViewController as? DetailViewController
            detailViewController?.news = self.newsResponse?[0]
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Requests
    
    func news() {
        NewsService().news(url: Constants.BASE_URL,
                           success: { (responseData: [NewsResponse]) in
                            self.newsResponse = responseData
                            APIPreferencesLoader.write(preferences: responseData)
                            self.configureUI()
                           }) { (errorMsg: String, errorValue: Int) in
            self.newsResponse = APIPreferencesLoader.load()
            self.configureUI()
        }
    }
    
    
    
    // MARK: - Table view delegate / data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsResponse?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NewsTableViewCell, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        if let bookmarksData = userDefaults.object(forKey: "bookmarks") as? [Int] {
            bookmars = bookmarksData
            if bookmars.contains(indexPath.row) {
                cell.bookmarkImage.image = cell.bookmarkImage.image?.withRenderingMode(.alwaysTemplate)
                cell.bookmarkImage.tintColor = .red
            } else {
                cell.bookmarkImage.image = cell.bookmarkImage.image?.withRenderingMode(.alwaysTemplate)
                cell.bookmarkImage.tintColor = .gray
            }
        }
       // cell.contentView.backgroundColor = .clear
        cell.titleLabel.text = newsResponse?[indexPath.row].title
        cell.categoryLabel.text = newsResponse?[indexPath.row].category
        cell.dateLabel.text = newsResponse?[indexPath.row].date?.getDateStringFromUTC(dateValue: newsResponse?[indexPath.row].date)
        cell.newsImage.sd_setImage(with: URL(string: newsResponse?[indexPath.row].coverPhotoUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "noImage"))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !(bookmars.contains(indexPath.row)) {
            bookmars.append(indexPath.row)
            userDefaults.set(bookmars, forKey: "bookmarks")
        }
        let selectedNews = newsResponse?[indexPath.row]
        if let news = selectedNews {
            delegate?.newsSelected(news)
        }
        
        if
            let detailViewController = delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
