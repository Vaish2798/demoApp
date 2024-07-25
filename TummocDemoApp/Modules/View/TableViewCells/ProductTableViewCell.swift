//
//  ProductTableViewCell.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 24/07/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    static var xibName = "ProductTableViewCell"
    static var cellIdentifier = "ProductTableViewCell"
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.outerView.layer.cornerRadius = 10
        self.outerView.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func plusClicked(_ sender: UIButton) {
    }
    func cellSetup(data: Item) {
        self.productName.text = data.name
        self.productPrice.text = "₹\(data.price ?? 0)"
        self.productImage.sd_setImage(with: URL(string: data.icon ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
}
