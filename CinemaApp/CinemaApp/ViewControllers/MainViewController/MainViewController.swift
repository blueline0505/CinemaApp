//
//  MainViewController.swift
//  CinemaApp
//
//  Created by DAVIDPAN on 2024/2/27.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var dataTableView: UITableView!
    
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Main View"
        
        bindViewModel()
    }
    
    func bindViewModel() {
        
    }

}
