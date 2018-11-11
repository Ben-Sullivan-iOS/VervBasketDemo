//
//  ViewController.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import UIKit

class SelectProductVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: SelectProductModelType = SelectProductModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func basketButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
}

extension SelectProductVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectProductVCCell", for: indexPath)
        let price = " : " + model.products[indexPath.row].priceString
        cell.textLabel?.text = model.products[indexPath.row].name + price
        return cell
    }
}

extension SelectProductVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.addToBasket(productIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
