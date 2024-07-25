//
//  CartViewController.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 24/07/24.
//

import UIKit

class CartViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var amountView: UIView!
    
    @IBOutlet weak var totallbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var subTotalLbl: UILabel!
    
    @IBOutlet weak var checkOutButton: UIButton!
    var cartArray = [Item]()
    var index = 0
    var count = 1
    var countLessThanOne = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.registerCells()
        self.amountView.layer.cornerRadius = 20
        self.checkOutButton.layer.cornerRadius = 10
        setData()
        addObserver()
    }
    override func viewDidDisappear(_ animated: Bool) {
        removeObserver()
    }
    func registerCells() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UINib(nibName: CartProductTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: CartProductTableViewCell.cellIdentifier)
    }
    @IBAction func backButtonClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addObserver() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "ProductChanged"), object: nil, queue: nil, using: catchNotificationToShowPrice)
    }
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ItemCountAPICalled"), object: nil)
    }
    func catchNotificationToShowPrice(notification: Notification) -> Void {
        print("Catch notification to show Item Count")
        setData()
    }
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartProductTableViewCell.cellIdentifier, for: indexPath) as! CartProductTableViewCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.delegate = self
        if self.cartArray.count > 0 {
            cell.cellSetup(data: self.cartArray[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
extension CartViewController: CartProductTableViewCellDelegate {
    func clickButton(index: Int, count: Int, countLessThanOne: Bool) {
        self.index = index
        self.count = count
        self.countLessThanOne = countLessThanOne
    }
    func setData() {
        if countLessThanOne == false {
            if self.cartArray.count > 0 {
                self.amountView.isHidden = false
                self.checkOutButton.isHidden = false
                var total = 0.0
                let price = self.cartArray[index].price ?? 0.00
                let discount = self.cartArray[index].discount ?? 0.00
                if discount > 0.00 && discount < price {
                    if count > 1 {
                        total = Double(Int(price) * count) - discount
                    } else {
                        total = price - discount
                    }
                } else {
                    total = price
                }
                self.subTotalLbl.text = "₹\(Int(price) * count)"
                self.discountLbl.text = "₹\(discount)"
                self.totallbl.text = "₹\(total)"
            } else {
                self.amountView.isHidden = true
                self.checkOutButton.isHidden = true
            }
        } else {
            self.cartArray = []
            self.amountView.isHidden = true
            self.checkOutButton.isHidden = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
