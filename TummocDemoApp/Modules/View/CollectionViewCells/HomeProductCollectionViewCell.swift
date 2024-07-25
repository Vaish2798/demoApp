//
//  HomeProductCollectionViewCell.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 24/07/24.
//

import UIKit
import SDWebImage
protocol HomeProductCollectionViewCellDelegate: AnyObject {
    func favButtonTapped(index: Int, isFav: Bool)
    func addButtonTapped(index: Int)
}
class HomeProductCollectionViewCell: UICollectionViewCell {
    static var xibName = "HomeProductCollectionViewCell"
    static var cellIdentifier = "HomeProductCollectionViewCell"
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productName: UILabel!
    var isFav = false
    var index = 0
    weak var delegate: HomeProductCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.outerView.layer.cornerRadius = 20
        self.outerView.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        self.delegate?.addButtonTapped(index: self.index)
    }
    @IBAction func favButtonTapped(_ sender: UIButton) {
        if !isFav {
            isFav = true
            favBtn.setImage(UIImage(named: "selected_icon"), for: .normal)
        } else {
            isFav = false
            favBtn.setImage(UIImage(named: "unselected_icon"), for: .normal)
        }
        self.delegate?.favButtonTapped(index: self.index, isFav: self.isFav)
    }
    
    func cellSetup(data: Item) {
        self.outerView.layer.cornerRadius = 20
        self.outerView.layer.borderColor = UIColor.black.cgColor
        self.productName.text = data.name
        self.price.text = "₹\(data.price ?? 0)"
        self.productImage.sd_setImage(with: URL(string: data.icon ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
}
