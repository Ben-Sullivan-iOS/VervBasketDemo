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
    
    @IBAction func checkoutTapped(_ sender: UIBarButtonItem) {
        transitionToCheckoutScreen()
    }
    
    func transitionToCheckoutScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        guard
//            let navController = storyboard.instantiateViewController(withIdentifier: "BasketNavController") as? UINavigationController,
//            let vc = navController.viewControllers.first as? BasketVC
//            else {
//                return
//        }
        
        guard
            let vc = storyboard.instantiateViewController(withIdentifier: "CheckoutVC") as? CheckoutVC,
            let model = self.model
            else {
                return
        }
        
        let checkoutVCModel = CheckoutVCModel(basket: model.basket)
        vc.model = checkoutVCModel
        checkoutVCModel.delegate = vc
        navigationController?.pushViewController(vc, animated: true)
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
