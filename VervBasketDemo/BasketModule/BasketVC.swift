//
//  BasketVC.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import UIKit

class BasketVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: BasketVCModelType?
    weak var selectProductVCDelegate: SelectProductVCType?
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        guard let model = model else { return }
        selectProductVCDelegate?.basketUpdated(basket: model.basket)
        dismiss(animated: true)
    }
}

extension BasketVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.basket.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketVCcell", for: indexPath) as! BasketCell
        if let model = model {
            cell.delegate = self
            cell.configure(withBasketItem: model.basket.items[indexPath.row])
        }
        return cell
    }
}

extension BasketVC: BasketVCType {
    func add(product: Product) {
        model?.increaseQuantity(product: product)
        tableView.reloadData()
    }
    
    func remove(product: Product) {
        model?.decreaseQuantity(product: product)
        tableView.reloadData()
    }
}

protocol BasketVCModelType {
    var basket: Basket { get }
    mutating func increaseQuantity(product: Product)
    mutating func decreaseQuantity(product: Product)
}

struct BasketVCModel: BasketVCModelType {
    
    var basket: Basket
    
    init(basket: Basket) {
        self.basket = basket
    }
    
    mutating func increaseQuantity(product: Product) {
        basket.add(product: product)
    }
    
    mutating func decreaseQuantity(product: Product) {
        basket.decreaseQuantity(forProduct: product)
    }
}
