//
//  ViewController.swift
//  Navigation
//
//  Created by Светлана on 3.10.22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pressBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = storyboard.instantiateViewController(withIdentifier: "MyViewController") as? MyViewController,
            let navController = navigationController else { return }
       
       navController.pushViewController(destinationViewController, animated: true)
    }
}

