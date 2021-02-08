//
//  NewsTableViewCell.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/2/21.
//


class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainBackgroundView.layer.cornerRadius = 8
        mainBackgroundView.layer.masksToBounds = true
        newsImage.layer.cornerRadius = 8
        newsImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            bookmarkImage.image = bookmarkImage.image?.withRenderingMode(.alwaysTemplate)
            bookmarkImage.tintColor = .red
        }
    }
}
