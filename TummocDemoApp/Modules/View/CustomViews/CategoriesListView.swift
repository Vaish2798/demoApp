//
//  CategoriesListView.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 25/07/24.
//

import Foundation
import UIKit
protocol CategoriesListViewDelegate: AnyObject {
    func cancelTap()
}
class CategoriesListView: UIView {
   
    @IBOutlet weak var outerView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    weak var delegate: CategoriesListViewDelegate?
    var categoryArray = [Categories]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        self.outerView.layer.cornerRadius = 20
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        self.outerView.layer.cornerRadius = 20
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("CategoriesListView", owner: self, options: nil)
        self.contentView.frame = frame
        self.addSubview(self.contentView)
        self.outerView.layer.cornerRadius = 20
        self.outerView.layer.masksToBounds = true 
        self.cancelButton.layer.cornerRadius = 25
        registerCells()
    }
    func registerCells() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UINib(nibName: CategoriesTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: CategoriesTableViewCell.cellIdentifier)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.delegate?.cancelTap()
    }
}
extension CategoriesListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryArray.count 
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.cellIdentifier, for: indexPath) as! CategoriesTableViewCell
        cell.selectionStyle = .none
        if self.categoryArray.count > 0 {
            cell.cellSetup(data: self.categoryArray[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
