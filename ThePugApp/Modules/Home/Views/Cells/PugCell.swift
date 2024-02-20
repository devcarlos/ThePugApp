//
//  PugwCell.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//

import UIKit
import SDWebImage

protocol PugCellDelegate: AnyObject {
    func didUpdatePug(pug: Pug?)
}

class PugCell: UICollectionViewCell {

    @IBOutlet weak var pugImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    private var pug: Pug?

    weak var delegate: PugCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

//        self.translatesAutoresizingMaskIntoConstraints = false

        setupUI()
    }

    func setupUI() {
        pugImage.setupRoundedCorners(radius: 12)
    }

    public func configure(with pug: Pug) {
        self.pug = pug
        pugImage.sd_imageIndicator = SDWebImageActivityIndicator.white
        pugImage.sd_setImage(with: pug.imageURL, placeholderImage: UIImage())

        resetLikes()
    }

    override func prepareForReuse() {
        pugImage.image = nil
    }

    @IBAction func likeAction(_ sender: UIButton) {
        self.pug?.likes += 1

        delegate?.didUpdatePug(pug: pug)

        resetLikes()
    }

    func resetLikes() {
        if self.pug?.likes ?? 0 > 0 {
            self.likeButton.tintColor = .red
        } else {
            self.likeButton.tintColor = .black
        }

        self.likeLabel.text = "\(self.pug?.likes ?? 0) likes"
    }
}
