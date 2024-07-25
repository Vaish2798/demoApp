//
//  CartProductTableViewCell.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 24/07/24.
//

import UIKit
protocol CartProductTableViewCellDelegate: AnyObject {
    func clickButton(index: Int, count: Int, countLessThanOne: Bool)
}

class CartProductTableViewCell: UITableViewCell {
    static var xibName = "CartProductTableViewCell"
    static var cellIdentifier = "CartProductTableViewCell"
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var outerView: UIView!
    var count = 1
    var index = 0
    var countLessThanOne = false
    weak var delegate: CartProductTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.outerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func plusClciked(_ sender: UIButton) {
        count += 1
        self.countLbl.text = "\(count)"
        self.delegate?.clickButton(index: self.index, count: self.count, countLessThanOne: self.countLessThanOne)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProductChanged"), object: nil)
    }
    
    @IBAction func minusClicked(_ sender: UIButton) {
        if count > 1 {
            count -= 1
            countLessThanOne = false
        } else {
            countLessThanOne = true
        }
        self.countLbl.text = "\(count)"
        self.delegate?.clickButton(index: self.index, count: self.count, countLessThanOne: self.countLessThanOne)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProductChanged"), object: nil)
    }
    func cellSetup(data: Item) {
        self.countLbl.text = "\(count)"
        self.productName.text = data.name
        self.productPrice.text = "₹\(data.price ?? 0)"
        self.productImage.sd_setImage(with: URL(string: data.icon ?? ""), placeholderImage: UIImage(named: "placeholder"))
    }
}
