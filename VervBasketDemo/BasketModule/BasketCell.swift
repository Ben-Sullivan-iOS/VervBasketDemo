//
//  BasketCell.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import UIKit

protocol BasketVCType: class {
    func add(product: Product)
    func remove(product: Product)
}

class BasketCell: UITableViewCell {
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    weak var delegate: BasketVCType?
    
    private var product: Product?
    
    @IBAction func addItemButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        delegate?.add(product: product)
    }
    
    @IBAction func removeItemButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        delegate?.remove(product: product)
    }
    
    func configure(withBasketItem item: BasketItem) {
        product = item.product
        productNameLabel.text = item.product.name
        quantityLabel.text = String(item.quantity)
    }
}
