//
//  GalleryViewController.swift
//  News
//
//  Created by AimageArrayrmenuhi Mkrtchyan on 2/6/21.
//


class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var type: String? = ""
    var gallery = [Gallery]()
    var video = [Video]()
    var selectedIndex: IndexPath? = IndexPath()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    private func configureUI() {
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.register(GalleryItemCell.self, forCellWithReuseIdentifier: Constants.GalleryCell)
        collectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
    }
}


// MARK: CollectionView Delegate / DataSource
extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case GalleryTypes.gallery.rawValue:
            return gallery.count
        default:
            return video.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.GalleryCell, for: indexPath) as! GalleryItemCell
        switch type {
        case GalleryTypes.gallery.rawValue:
            cell.galleryImage.sd_setImage(with: URL(string: gallery[indexPath.row].thumbnailUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "noImage"))
        default:
            cell.galleryImage.sd_setImage(with: URL(string: video[indexPath.row].thumbnailUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "noImage"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        switch type {
        case GalleryTypes.gallery.rawValue:
            performSegue(withIdentifier: Constants.ShowPreview, sender: self)
        default:
            if Connectivity.isConnectedToInternet() {
                performSegue(withIdentifier: Constants.ShowYoutube, sender: self)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        if DeviceInfo.Orientation.isPortrait {
            return CGSize(width: width/4 - 1, height: width/4 - 1)
        } else {
            return CGSize(width: width/6 - 1, height: width/6 - 1)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch type {
        case GalleryTypes.gallery.rawValue:
            if segue.identifier == Constants.ShowPreview {
                if let vc = segue.destination as? PreviewViewController {
                    vc.gallery = gallery
                    vc.passedContentOffset = selectedIndex ?? IndexPath()
                }
            }
        default:
            if segue.identifier == Constants.ShowYoutube {
                if let vc = segue.destination as? VideoViewController {
                    vc.videoId = video[selectedIndex?.row ?? 0].youtubeId
                }
            }
        }
    }
}


