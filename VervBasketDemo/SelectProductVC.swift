//
//  ViewController.swift
//  VervBasketDemo
//
//  Created by Ben Sullivan on 11/11/2018.
//  Copyright © 2018 Future Platforms. All rights reserved.
//

import UIKit

protocol SelectProductVCType: class {
    func basketUpdated(basket: Basket)
}

class SelectProductVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: SelectProductVCModelType = SelectProductVCModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //  TODO: move navigation logic to coordinator
    @IBAction func basketButtonTapped(_ sender: UIBarButtonItem) {
        transitionToBasket()
    }
    
    func transitionToBasket() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard
            let navController = storyboard.instantiateViewController(withIdentifier: "BasketNavController") as? UINavigationController,
            let vc = navController.viewControllers.first as? BasketVC
            else {
                return
        }
        
        let model = BasketVCModel(basket: self.model.basket)
        vc.model = model
        vc.selectProductVCDelegate = self
        present(navController, animated: true)
    }
    
}

extension SelectProductVC: SelectProductVCType {
    func basketUpdated(basket: Basket) {
        model.setNewBasket(basket)
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
