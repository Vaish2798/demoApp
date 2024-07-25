//
//  CategoriesTableViewCell.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 25/07/24.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLbl: UILabel!
    static var xibName = "CategoriesTableViewCell"
    static var cellIdentifier = "CategoriesTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellSetup(data: Categories) {
        self.categoryLbl.text = data.name ?? ""
    }
}
