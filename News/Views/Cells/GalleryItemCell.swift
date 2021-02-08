//
//  GalleryItemCell.swift
//  News
//
//  Created by Armenuhi Mkrtchyan on 2/6/21.
//


class GalleryItemCell: UICollectionViewCell {
    
    var galleryImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        galleryImage.contentMode = .scaleAspectFill
        galleryImage.clipsToBounds = true
        addSubview(galleryImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        galleryImage.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
