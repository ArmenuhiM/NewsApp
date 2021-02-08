//
//  DetailViewController.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//

enum GalleryTypes: String {
    case gallery, video
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var videosButton: UIButton!
    
    
    var news: NewsResponse? {
        didSet {
            refreshUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func refreshUI() {
        loadViewIfNeeded()
        titleLabel.text = news?.title
        categoryLabel.text = news?.category
        dateLabel.text = news?.date?.getDateStringFromUTC(dateValue: news?.date)
        newsImage.sd_setImage(with: URL(string: news?.coverPhotoUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "noImage"))
        bodyLabel.text? = news?.body?.stripOutHtml() ?? ""
        configureGalleryUI()
        configureVideoUI()
    }
    
    
    private func configureGalleryUI() {
        guard (news?.gallery) == nil else {
            galleryButton.isEnabled = true
            galleryButton.setTitleColor(.red, for: .normal)
            return
        }
        galleryButton.isEnabled = false
        galleryButton.setTitleColor(.lightGray, for: .normal)
    }
    
    
    
    private func configureVideoUI() {
        guard (news?.video) == nil else {
            videosButton.isEnabled = true
            videosButton.setTitleColor(.red, for: .normal)
            return
        }
        videosButton.isEnabled = false
        videosButton.setTitleColor(.lightGray, for: .normal)
    }

        
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.ShowGallery:
            if let vc = segue.destination as? GalleryViewController {
                vc.type = GalleryTypes.gallery.rawValue
                vc.gallery = news?.gallery ?? []
            }
        default:
            if let vc = segue.destination as? GalleryViewController {
                vc.type = GalleryTypes.video.rawValue
                vc.video = news?.video ?? []
            }
        }
    }
}

extension DetailViewController: NewsSelectionDelegate {
    func newsSelected(_ newNews: NewsResponse) {
        news = newNews
    }
}
