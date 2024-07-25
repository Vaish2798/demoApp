//
//  HomeViewController.swift
//  TummocDemoApp
//
//  Created by Vaishnavi Kari on 24/07/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var categoriesButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    var jsonData: [String: Any]?
    var isClicked = false
    var isFav = false
    var favouritArray = [Item]()
    var cartArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.categoriesButton.layer.cornerRadius = 10
        self.registerCells()
    }
    func registerCells() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UINib(nibName: HomeCategoryListTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: HomeCategoryListTableViewCell.cellIdentifier)
    }
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @IBAction func cartIconClick(_ sender: UIButton) {
        DispatchQueue.main.async {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let viewControl = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            viewControl.cartArray = self.cartArray
            self.navigationController?.pushViewController(viewControl, animated: true)
          }
        }
    }
    @IBAction func favButtonClick(_ sender: UIButton) {
        DispatchQueue.main.async {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let viewControl = storyBoard.instantiateViewController(withIdentifier: "FavouriteViewController") as? FavouriteViewController {
            viewControl.favArray = self.favouritArray
            self.navigationController?.pushViewController(viewControl, animated: true)
          }
        }
    }
    
    @IBAction func categoriesClicked(_ sender: UIButton) {
        self.categoriesButton.isHidden = true
        self.addCategoriesPopUp()
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loadJson().categories?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCategoryListTableViewCell.cellIdentifier, for: indexPath) as! HomeCategoryListTableViewCell
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.delegate = self
        if self.loadJson().categories?.count ?? 0 > 0 {
            cell.categoryData = self.loadJson().categories?[indexPath.row] ?? Categories()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isClicked {
            return 60
        } else {
            return UITableView.automaticDimension
        }
    }
}
extension HomeViewController: HomeCategoryListTableViewCellDelegate, CategoriesListViewDelegate {
    func cancelTap() {
        removeSubView(1000)
        self.categoriesButton.isHidden = false
    }
    func addButtonTapped(index: Int) {
        for data in self.loadJson().categories ?? [] {
            if data.items?[index].id == self.loadJson().categories?[index].items?[index].id {
                self.cartArray.append( data.items?[index] ?? Item())
                break
            }
        }
    }
    func favButtonTapped(index: Int, isFav: Bool) {
        for data in self.loadJson().categories ?? [] {
            if data.items?[index].id == self.loadJson().categories?[index].items?[index].id {
                data.items?[index].isFavourite = isFav
                if data.items?[index].isFavourite == true {
                    self.favouritArray.append( data.items?[index] ?? Item())
                } else {
                    self.favouritArray.remove(at: index)
                }
                break
            }
        }
    }
    func arrowClicked(index: Int) {
        self.isClicked = !(self.isClicked)
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    func addCategoriesPopUp() {
        DispatchQueue.main.async {
            let categoriesPopUp = CategoriesListView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            categoriesPopUp.tag = 1000
            categoriesPopUp.delegate = self
            categoriesPopUp.outerView.layer.cornerRadius = 20
            categoriesPopUp.categoryArray = self.loadJson().categories ?? [Categories]()
            self.view.addSubview(categoriesPopUp)
        }
    }
    func removeSubView(_ tag: Int) {
        DispatchQueue.main.async {
            for subview in (self.view.subviews) where (subview.tag == tag) {
                subview.removeFromSuperview()
            }
        }
    }
    func loadJson() -> DemoModel {
        let items = Bundle.main.decode(type: DemoModel.self, from: "DemoJson.json")
        return items
    }
}
extension Bundle {
    func decode<T: Codable>(type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("No file named: \(file) in Bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load")
        }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundel, missing file '\(key.stringValue)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Type mismatch context \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(type) - context: \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Wrong JSON")
        } catch {
            fatalError("Filed to decode \(file) from bundle")
        }
    }
}
